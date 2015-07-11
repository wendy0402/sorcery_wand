module SorceryWand
  module Submodules
    # This Submodules is built to add ability archive old password and every
    # new password will be checked with the last x(from sorcery wand config)
    # archived. If there is one that match, it is not allowed
    module PasswordArchivable

      # inject module password archivable  for user to User class
      def self.inject!
        user_models_part = SorceryWand::Submodules::PasswordArchivable::Model
        SorceryWand.user_class.send(:include, user_models_part)
        begin
          PasswordArchive.send(:include, SorceryWand::Submodules::PasswordArchivable::PasswordArchives)
        rescue NameError
          raise 'Model PasswordArchive is not created yet'
        end
      end

      module Model
        def self.included(base)
          base.extend ClassMethods
          base.send(:include, InstanceMethods)

          base.class_eval do
            # sorcery_adapter.define_callback :before, :update, :same_with_old_pass?,
            #   if: Proc.new { |user| user.send(sorcery_config.password_attribute_name).present? }
            validate :same_with_archived_password?, on: :update
            sorcery_adapter.define_callback :before, :update, :update_archive,
              if: Proc.new { |user| user.send(sorcery_config.password_attribute_name).present? }
          end
        end
        module InstanceMethods
          # compare new password with other archived password
          attr_reader :old_crypted_password, :old_salt
          def same_with_archived_password?
            count = SorceryWand.config.password_archivable_count
            old_passwords = password_archives.order('created_at desc').limit(count)
            if old_passwords.size > 0 && old_passwords.any?{ |old_password| old_password.match?(password) }
                errors.add(:password, 'has been taken before')
            end
          end

          def update_archive
            if crypted_password_was.blank? || salt_was.blank?
              return
            end
            total_archivable = SorceryWand.config.password_archivable_count
            current_archivable = password_archives.order('created_at desc').
              limit(total_archivable - 1).to_a
            new_archived = PasswordArchive.new(
              crypted_password: crypted_password_was,
              salt: salt_was,
              user: self,
              created_at: Time.zone.now
              )
            archived = current_archivable + [new_archived]
            self.password_archives = archived
          end
        end
        module ClassMethods;end
      end
    end
  end
end

module SorceryWand
  module Submodules
    # This Submodules is built to add ability archive old password and every
    # new password will be checked with the archived password.
    # If there is one that match, it is not allowed
    module PasswordArchivable
      def self.inject!
        # inject module password archivable  for user to User class
        user_models_part = SorceryWand::Submodules::PasswordArchivable::Model
        SorceryWand.user_class.send(:include, user_models_part)

        #include password_archive module to PasswordArchive class
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
            validate :same_with_archived_password?, on: :update
            sorcery_adapter.define_callback :before, :update, :update_archive,
              if: Proc.new { |user| user.send(sorcery_config.password_attribute_name).present? }
          end
        end
        module InstanceMethods
          # compare new password with other archived password
          def same_with_archived_password?
            count = SorceryWand.config.password_archivable_count
            old_passwords = password_archives.order('created_at desc').limit(count)
            if old_passwords.size > 0 && old_passwords.any?{ |old_password| old_password.match?(password) }
                errors.add(:password, 'has been taken before')
            end
          end

          # add old password to archive. if total archived reached limit, then
          # delete the oldest
          def update_archive
            if crypted_password_was.blank? || salt_was.blank?
              return
            end
            total_archivable = SorceryWand.config.password_archivable_count.to_i

            if total_archivable > 0
              new_archived = PasswordArchive.create(
                crypted_password: crypted_password_was,
                salt: salt_was,
                user: self,
                created_at: Time.zone.now
                )

              self.password_archives.order('created_at desc').
                offset(total_archivable).
                destroy_all
            else
              ## if total_archivable is 0, no need to create unnecessary record
              self.password_archives.destroy_all
            end
          end
        end
        module ClassMethods;end
      end
    end
  end
end

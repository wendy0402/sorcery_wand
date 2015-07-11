module SorceryWand
  module Submodules
    module PasswordArchivable
      module PasswordArchives

        def self.included(base)
          base.send(:include, InstanceMethods)
          base.extend ClassMethods
        end

        module InstanceMethods
          #compare pass with encrypted password in database
          def match?(pass)
            _crypted = crypted_password
            encryption_provider = User.sorcery_config.encryption_provider
            #
            return _crypted == pass if encryption_provider.nil?

            encryption_provider = User.sorcery_config.encryption_provider
            encryption_provider.matches?(crypted_password, pass, salt)
          end
        end
        module ClassMethods;end
      end
    end
  end
end

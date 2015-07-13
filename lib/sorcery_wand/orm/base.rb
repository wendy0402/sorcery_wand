module SorceryWand
  module Orm
    module Base
      def inject_sorcery_wand!
        if SorceryWand.config.user_class.present? && self.to_s == SorceryWand.config.user_class
          SorceryWand::Submodules.inject_submodules!
        else
          raise 'SorceryWand user_class has not been declared in initializer or `inject_sorcery_wand` called in wrong model'
        end
      end
    end
  end
end

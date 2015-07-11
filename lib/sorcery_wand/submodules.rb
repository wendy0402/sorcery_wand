module SorceryWand
  module Submodules
    # inject every submodules that is defined in sorcery_wand initializer
    def self.inject_submodules!
      SorceryWand.config.submodules.each do |submodule|
        ::SorceryWand::Submodules.const_get(class_name(submodule)).inject!
      end
    end
    private

    def self.class_name(submodule)
      submodule.split('_').map {|p| p.capitalize}.join
    end
  end
end

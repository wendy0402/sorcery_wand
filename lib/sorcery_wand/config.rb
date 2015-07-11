module SorceryWand
  class Config
    attr_accessor :submodules, :user_class
    #password_archivable config
    attr_accessor :password_archivable_count

    def initialize
      #set default values
      @submodules = []
      @password_archivable_count = 5
    end

  end
end

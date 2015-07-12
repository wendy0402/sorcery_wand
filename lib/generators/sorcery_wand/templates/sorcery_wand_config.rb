SorceryWand.configure do |config|
  ##submodules
  # list submodules that is wanted to be used
  # ex: config.submodules = ['password_archivable']
  # options: 'password_archivable'
  config.submodules = []
  ## password_archivable ##

  # total max password archived
  # default: 5
  # config.password_archivable_count = 5
  config.user_class = ''
end

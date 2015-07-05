class User < ActiveRecord::Base
  has_many :password_archives
end
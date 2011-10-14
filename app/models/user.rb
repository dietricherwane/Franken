class User < ActiveRecord::Base
  has_many :messages
  #accepts_nested_attributes_for :messages
end

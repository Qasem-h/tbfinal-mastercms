class Country < ActiveRecord::Base
  has_many :leagues
  has_many :matches, :through => :leagues
end

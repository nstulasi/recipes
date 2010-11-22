class Recipe < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :name, :ingredients, :directions
  
  has_many :tags
 
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

end
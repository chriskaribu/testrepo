class Alley < ActiveRecord::Base
  
  scope :active, -> { where(active: true) }
  
  validates :name, presence: true
end
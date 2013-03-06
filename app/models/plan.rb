class Plan < ActiveRecord::Base
  validates_presence_of :stripe_id
  validates_uniqueness_of :stripe_id
  attr_accessible :name, :stripe_id, :price, :credits  
  has_many :subscriptions
end

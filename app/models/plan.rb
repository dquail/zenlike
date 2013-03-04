class Plan < ActiveRecord::Base
  validates_presence_of :stripe_id
  validates_uniqueness_of :stripe_id
    
  has_many :subscriptions
end

class Task < ApplicationRecord
  has_many :conversations
  
  allowed_types = ['material', 'help']
  
  belongs_to :user
  validates_presence_of :title, :description, :lat, :lng, :user_id, :task_type

	validates :title, length: { in: 2...50, 
  message: "title must be between 2 and 50 letters"  }
  
  validates :description, length: { maximum: 300,
  message: "your description is too long ,maximum 300 letters"  }

  validates_inclusion_of :task_type, { in: allowed_types, 
  message: "we don't support this type of request" }

  validates :lat, numericality: {
    only_integer: false,
    greater_than_or_equal_to: 50, 
    less_than_or_equal_to: 52,
    message: "we currently don't work in this neighborhood"}

  validates :lng, numericality: {
    only_integer: false,
    greater_than_or_equal_to: -1, 
    less_than_or_equal_to: 1,
    message: "we currently doni't work in this neighborhood"}

  after_create_commit { TaskBroadcastJob.perform_later(self) }
end

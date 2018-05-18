class Task < ApplicationRecord
  has_many :conversations
  has_many :messages
  allowed_types = ['material', 'help']
  
  belongs_to :user
  validates_presence_of :title, :description, :lat, :lng, :user_id, :task_type

	validates :title, length: { in: 2...50, 
  message: "title must be between 2 and 50 letters"  }
  
  validates :description, length: { maximum: 300,
  message: "your description is too long ,maximum 300 letters"  }

  validates_inclusion_of :task_type, { in: allowed_types, 
  message: "we don't support this type of request" }

  geocoded_by :address, :latitude => :lat, :longitude => :lng

  validates :lat, numericality: { only_integer: false}

  validates :lng, numericality: { only_integer: false}

  after_create_commit { TaskBroadcastJob.perform_later(self) }
end

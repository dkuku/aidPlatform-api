class Conversation < ApplicationRecord
  belongs_to :volunteer, :class_name => "User"
  belongs_to :task_owner, :class_name => "User"
  belongs_to :task, class_name: 'Task'
  has_many :messages, dependent: :destroy
  validates_presence_of :volunteer_id, :task_id
  validates_uniqueness_of :volunteer_id, :scope => :task_id
  scope :between, ->(volunteer_id, task_id) {where(volunteer_id: volunteer_id, task_id: task_id)}
end

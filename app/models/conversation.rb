class Conversation < ApplicationRecord
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :task, :foreign_key => :task_id, class_name: 'Task'
  has_many :messages, dependent: :destroy
  validates_presence_of :sender_id, :task_id
  validates_uniqueness_of :sender_id, :scope => :task_id
  scope :between, ->(sender_id, task_id) {where(sender_id: sender_id, task_id: task_id)}
end

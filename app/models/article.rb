class Article < ActiveRecord::Base
	validates :title, presence: true
	validates :description, presence: true

	belongs_to :user
	has_many :comments, dependent: :destroy

	default_scope { order(created_at: :desc)}
end

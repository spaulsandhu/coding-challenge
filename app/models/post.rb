class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:title, :body]
  
  paginates_per 5

  belongs_to :user
  has_many :comments, dependent: :destroy

  alias_attribute :author, :user

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  default_scope { order('created_at ASC') }
end

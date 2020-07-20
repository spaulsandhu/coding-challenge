class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true

  alias_attribute :author, :user

  validates :body, presence: true, length: { minimum: 5 }
end

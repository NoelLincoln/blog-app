class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  before_create :initialize_counters

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :update_user_posts_counter

  def update_user_posts_counter
    author&.update(posts_counter: author.posts.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  after_save :update_posts_counter

  private

  def initialize_counters
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_create :update_user_posts_counter

  private

  def update_user_posts_counter
    user&.update(posts_counter: user.posts.count)
  end
end

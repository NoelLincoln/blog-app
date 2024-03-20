# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :comments
  has_many :posts, foreign_key: 'author_id'
  has_many :likes

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  def recent_posts
    posts.order(created_at: :asc).limit(3)
  end

  before_validation :set_default_photo, on: :create

  private

  def set_default_photo
    self.photo ||= generate_gravatar_url(email)
  end

  def generate_gravatar_url(email, size: 300)
    # Generate a Gravatar URL based on the user's email
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
  end
end

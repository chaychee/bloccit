class Post < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  include MongoMysqlRelations

  from_mysql_has_many :comments, :class => Comment, :foreign_key => "post_id"
# TODO Mongo destroy?
#  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  default_scope { order('rank DESC') }

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }
  
  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
     age = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
     new_rank = points + age

     update_attribute(:rank, new_rank)
  end

  def save_with_initial_vote
    ActiveRecord::Base.transaction do 
      self.save!
      user.votes.create!(value: 1, post: self)
      return true
    end
    rescue => e
    return false
  end

end

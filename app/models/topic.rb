class Topic < ActiveRecord::Base
  include Paginate

  has_many :posts
end

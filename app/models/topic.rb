class Topic < ActiveRecord::Base
  include Paginate

  has_many :posts

  def paginate(resource)
    resource
  end
end

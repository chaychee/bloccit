class Topic < ActiveRecord::Base
#  include Paginate

  has_many :posts

 

# A paginate method on the Post and Topic class, which returns the specified subset of posts or topics. As a bonus, define this method in a module you include in both classes (lib/paginate.rb is a good place to keep it), to keep your code DRY. The paginate method should take a hash with per_page and page attributes, just like the gem's methods. You'll probably want to use AR's limit method, which can take an offset argument, like so:
# page = 0 # Or any page number (starts at 0)

# Resource.limit(10).offset(page * 10)
# #=> Returns an AR relation of ten Resource objects

# Resource.limit(10).offset(page * 10) do |relation_of_ten|
#   do_something_with(relation_of_ten)
# end

  
  @paginate_total_pages
  @paginate_page

  attr_accessor :paginate_total_pages, :paginate_page

  # #paginate(options) ⇒ Object
  # :page - page number to get
  # :per_page - number of records per page
  # note this will return array of Record objects
  def self.paginate(options)
    # :page is required key.  If no page value supplied, default to page 1.
    page = options.fetch(:page) { raise ArgumentError, ":page parameter required" } || "1"
  
    # Default to 10 if not specified
    per_page = options[:per_page] || 10

    # Compute the total pages based on total record count
    record_count = self.count
    total_pages = (record_count > 0) ? ((record_count-1)/per_page).to_i + 1 : 0

    rel = self.limit(per_page).offset((page.to_i-1)*per_page)
    
    # TODO Store paging state information in the objects themselves for now
    rel.each do |relation|
      relation.paginate_page = page
      relation.paginate_total_pages = total_pages
    end
    rel
  end

end

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

  # default 10.  Can override
  @@per_page = 10

  def self.per_page
    @@oaginate_per_page
  end
  
  def self.per_page=(per_page)
    @@paginate_per_page = per_page
  end

   
  @paginate_total_pages
  @paginate_page

  attr_accessor :paginate_total_pages, :paginate_page

  # #paginate(options) ⇒ Object
  # :page - page number to get
  # :per_page - number of records per page
  # note this will return array of Record objects
  def self.paginate(options)
    #TODO
    p options.inspect
    
    # TODO per_page value should use explicitly declared in method, class override, or global default
    # as per will_paginate
    page = (options[:page]) ? (options[:page].to_i - 1) : 0
    per_page = options[:per_page] || self.per_page

 
    # Compute the total pages based on total record count 
    total_pages = (per_page > 0) ? ((self.count+1)/per_page).to_i + 1 : 0

    puts "self.paginate page = #{page}, per_page = #{per_page}, total_pages = #{total_pages}"


    rel = self.limit(per_page).offset(page*per_page)
    rel.each do |relation|
      relation.paginate_page = page
      relation.paginate_total_pages = total_pages
    end
    rel
  end

end

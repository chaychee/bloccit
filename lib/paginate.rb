module Paginate

  # Note: this block of code allows any class that includes Paginate to contain static methods
  def self.included(o)
    o.extend(ClassMethods)
  end

  module ClassMethods

    # #paginate(options) ⇒ Object
    # :page - page number to get
    # :per_page - number of records per page
    def paginate(options)
      # :page is required key.  If no page value supplied, default to page 1.
      page = options.fetch(:page) { raise ArgumentError, ":page parameter required" } || "1"
    
      # Default to 10 if not specified
      per_page = options[:per_page] || 10

      # Compute the total pages based on record count
      record_count = self.count
      total_pages = (record_count > 0) ? ((record_count-1)/per_page).to_i + 1 : 0

      rel = self.limit(per_page).offset((page.to_i-1)*per_page)
      
      # TODO Store paging state information in the objects themselves for now
      # Discuss with mentor cleaner way to do this - perhaps create a 
      # Paginate Collection
      rel.each do |relation|
        relation.paginate_page = page
        relation.paginate_total_pages = total_pages
      end
      rel
    end

  end

  @paginate_total_pages
  @paginate_page

  attr_accessor :paginate_total_pages, :paginate_page

  def paginate (options)
    self.paginate(options)
  end

end

def will_paginate (objects)
  # Retrieve current page and page count state information from collection
  # Don't render anything unless there is more than one page
  return nil unless objects && objects[0] && objects[0].paginate_page && objects[0].paginate_total_pages
  current_page = objects[0].paginate_page.to_i
  total_pages = objects[0].paginate_total_pages.to_i
  return nil unless (total_pages > 1)

  # Build pagination html
  content_tag(:div, class: "pagination") do 
    # Build the html for the "Previous" link.  Disable if we are on the first page.
    if (current_page == 1)
      concat(content_tag(:span, '&#8592; Previous'.html_safe, class: "previous_page disabled")) 
    else
      concat(link_to('&#8592; Previous'.html_safe, page_fullpath(request, current_page-1), class: "previous_page"))
    end
    concat(" ")
    
    # Build a page link for each page.  Disable the link on the current page.
    1.upto(total_pages) do |page_num|
      if(page_num==current_page)
        concat(content_tag(:em, "#{page_num}", class: "current"))
      else
        concat(link_to("#{page_num}", page_fullpath(request, page_num)))
      end
      concat(" ")
    end

    # Build the html for the "Next" link.  Disable if we are on the last page.
    if (current_page == total_pages)
      concat(content_tag(:span, 'Next &#8594;'.html_safe, class: "next_page disabled")) 
    else
      concat(link_to('Next &#8594;'.html_safe, page_fullpath(request, current_page+1), class: "next_page"))
    end
  end
end 

def page_fullpath(request, page)
  request.parameters.merge(page: page)
end


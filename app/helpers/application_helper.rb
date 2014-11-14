module ApplicationHelper

  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end

  
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: false}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end


  def will_paginate (objects)
    # Retrieve current page and page count state information from collection
    # Don't render anything unless there is more than one page
    return nil unless objects && objects[0] && objects[0].paginate_page && objects[0].paginate_total_pages
    current_page = objects[0].paginate_page.to_i
    total_pages = objects[0].paginate_total_pages.to_i
    puts "current_page #{current_page}  total_pages #{total_pages}"
    return nil unless (total_pages > 1)

    index_url = url_for_collection(objects)
    puts page_url(index_url,1)

    # Build pagination html
    content_tag(:div, class: "pagination") do 
      # Build the html for the previous link.  Disable if we are on the first page.
      if (current_page == 1)
        concat(content_tag(:span, '&#8592; Previous'.html_safe, class: "previous_page disabled")) 
      else
        concat(link_to('&#8592; Previous'.html_safe, page_url(index_url, current_page-1), class: "previous_page"))
      end
      concat(" ")
      
      # Build a page link for each page.  Disable the link on the current page.
      1.upto(total_pages) do |page_num|
        if(page_num==current_page)
          concat(content_tag(:em, "#{page_num}", class: "current"))
        else
          concat(link_to("#{page_num}", page_url(index_url, page_num)))
        end
        concat(" ")
      end

      if (current_page == total_pages)
        concat(content_tag(:span, 'Next &#8594;'.html_safe, class: "next_page disabled")) 
      else
        concat(link_to('Next &#8594;'.html_safe, page_url(index_url, current_page+1), class: "next_page"))
      end
    end
  end 

  #TODO Review with mentor.  Is there not a helper that can take an array of objects
  # and return the controller mapped url?
  # e.g. url_for @posts  yields /posts. 
  def url_for_collection(objects)
    url = url_for(objects[0])
    url[0, url.rindex('/')]
  end

  def page_url(url, page)
    "#{url}?page=#{page}"
  end

end

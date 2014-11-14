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
    #"<h1>will_paginate stub</h1>".html_safe
    

    # Sample code from posts

    # "<div class="pagination"><span class="previous_page disabled">&#8592; Previous</span> <em class="current">1</em> <a rel="next" href="/topics/6?page=2">2</a> <a class="next_page" rel="next" href="/topics/6?page=2">Next &#8594;</a></div>"
    
    # Sample code for topics
    # ? How does it know the controller path??? to build
    # # Also needs to know total pages in the record set (up to a max)

    # Retrieve current page and page count state information
    return nil unless objects && objects[0] && objects[0].paginate_page && objects[0].paginate_total_pages
    current_page = objects[0].paginate_page
    total_pages = objects[0].paginate_total_pages
    puts "total_pages #{total_pages}"
    return nil unless (total_pages > 1)

    # build the html.  
    output = content_tag(:p, "Hello world!")
    puts output
    output = "<div class=\"pagination\"><a class=\"previous_page\" rel=\"prev start\" href=\"/topics?page=1\">&#8592; Previous</a><a rel=\"prev start\" href=\"/topics?page=1\">1</a><em class=\"current\">2</em><span class=\"next_page disabled\">Next &#8594;</span></div>".html_safe
    content_tag(:div, class: "pagination") do 
      content_tag(:p, "Hello world!")
    end
  end 

end

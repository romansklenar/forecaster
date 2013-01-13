# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper

  def title(page_title)
    content_for(:title) { h(page_title.to_s) }
  end

  def description(page_description)
    content_for(:description) { h(page_description.to_s) }
  end

  def keywords(page_keywords)
    content_for(:keywords) { h(page_keywords.to_s) }
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def meta(*args)
    content_for(:head) { meta_tag(*args) }
  end
  
  
  # Renders a title tag for use in the HEAD section of an html document.
  def title_tag(title)
    content_tag :title, strip_tags(title).strip
  end

  # Renders a description meta tag for use in the HEAD section of an html document.
  def description_meta_tag(description)
    meta_tag :description, strip_tags(description).strip
  end

  # Renders a keywords meta tag for use in the HEAD section of an html document.
  def keywords_meta_tag(keywords)
    meta_tag :keywords, strip_tags(keywords).strip
  end

  # Renders a meta tag for use in the HEAD section of an html document.
  def meta_tag(name, value, http_equiv = false)
    return nil if value.blank?
    http_equiv = true if %w{expires pragma content-type content-script-type content-style-type default-style content-language refresh window-target cache-control vary}.include? name
    if http_equiv
      tag :meta, :"http-equiv" => name, :content => value
    else 
      tag :meta, :name => name, :content => value
    end
  end

end

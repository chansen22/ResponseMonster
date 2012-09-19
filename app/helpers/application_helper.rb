module ApplicationHelper
  include SessionsHelper

  def full_title(page_title)
    base_title = "Response Monster"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end

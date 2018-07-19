module CommentsHelper

  def break_the_lines(text)
    text.to_s.gsub(/\n/, '<br/>').html_safe
  end
end

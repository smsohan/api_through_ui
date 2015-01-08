module ApplicationHelper
  def markdown(content)
    GitHub::Markdown.render_gfm(strip_tags(content)).strip
  end

end

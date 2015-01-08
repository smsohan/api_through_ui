module ApplicationHelper
  def markdown(content)
    GitHub::Markdown.render_gfm(strip_tags(content)).try(:strip)
  end

end

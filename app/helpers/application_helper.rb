module ApplicationHelper
  def markdown(content)
    GitHub::Markdown.render_gfm(strip_tags(content)).try(:strip).gsub("&amp;quot;", '"')
  end

end

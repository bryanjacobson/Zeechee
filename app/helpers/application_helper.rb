module ApplicationHelper
  def default_topic_icon(path)
    return path if !path.blank?
    else "t.png"
  end
end

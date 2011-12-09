module ApplicationHelper
  def default_topic_icon(path)
    return path if !path.blank?
    return "t.jpg"
  end
end

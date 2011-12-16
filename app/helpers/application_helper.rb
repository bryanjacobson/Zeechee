module ApplicationHelper
  def default_icon(path, default_path='t.jpg')
    return path if !path.blank?
    return default_path
  end
end

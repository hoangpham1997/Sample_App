module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "ror_tut_sample"
    if page_title.blank? ? base_title : page_title + " | " + base_title
    end
  end
end

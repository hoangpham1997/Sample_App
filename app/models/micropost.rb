class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true,
    length: {maximum: Settings.length_of_content}
  validates :image, content_type: {in: Settings.some_vision_type,
                                   message: I18n.t("must_valid_image")},
    size: {less_than: 5.megabytes,
           message: I18n.t("less_than5MB")}
  scope :order_by_created_at, ->{order created_at: :desc}

  def display_image
    image.variant resize_to_limit: [Settings.limit_of_image,
      Settings.limit_of_image]
  end
end

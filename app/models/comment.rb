class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :body, presence: true

  validates :user_name, presence: true, unless: :present_user?

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def present_user?
    user.present?
  end
end

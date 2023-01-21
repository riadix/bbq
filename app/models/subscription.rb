class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name,
            presence: true, unless: :present_user?
  validates :user_email,
            presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: :present_user?

  validates :user, uniqueness: {scope: :event_id}, if: :present_user?
  validates :user_email, uniqueness: {scope: :event_id}, unless: :present_user?

  validate :not_creator

  def not_creator
    if user == event.user
      errors.add('Ошибка', 'Вы создатель')
    end
  end

  def present_user?
    user.present?
  end

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end
end

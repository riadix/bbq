class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  with_options if: -> { user.present? } do
    validates :user, uniqueness: {scope: :event_id}
    validate :must_not_be_creator
  end

  with_options unless: -> { user.present? } do
    validates :user_email, uniqueness: {scope: :event_id}
    validates :user_name,
              presence: true
    validates :user_email,
              presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
    validate :must_have_unique_email
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

  private

  def must_have_unique_email
    if User.where(email: user_email).present?
      errors.add(:user, :must_have_unique_email)
    end
  end

  def must_not_be_creator
    if user == event.user
      errors.add(:user, :must_not_be_creator)
    end
  end
end

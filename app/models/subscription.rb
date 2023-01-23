class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  with_options if: :present_user? do
    validates :user, uniqueness: {scope: :event_id}
    validate :validate_guest
  end

  with_options unless: :present_user? do
    validates :user_email, uniqueness: {scope: :event_id}
    validates :user_name,
              presence: true
    validates :user_email,
              presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
    validate :validate_email_uniqueness
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

  private

  def validate_email_uniqueness
    if User.where(email: user_email).present?
      errors.add(I18n.t('error.subscription.attribute'),
                 I18n.t('error.subscription.email_exists.message'))
    end
  end

  def validate_guest
    if user == event.user
      errors.add(I18n.t('error.subscription.attribute'),
                 I18n.t('error.subscription.is_creator.message'))
    end
  end
end

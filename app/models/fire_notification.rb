class FireNotification < ActiveRecord::Base

  class << self
    include Notification
  end

  belongs_to :subscriber
  belongs_to :fire_alert

  scope :new_notifications, -> { where("created_at >= ?", 15.minute.ago) }
end
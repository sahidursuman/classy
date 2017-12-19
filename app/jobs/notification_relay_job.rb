class NotificationRelayJob < ApplicationJob
  def perform notification
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}",
      {unread_count: notification.recipient.received_notifications.unread.size}
  end
end

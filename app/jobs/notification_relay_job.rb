class NotificationRelayJob < ApplicationJob
  def perform notification
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", {}
  end
end

class Notification::NotifyCenterManagersService
  attr_reader :center, :notifiable, :action, :creater, :creatable

  def initialize center, notifiable, action
    @center = center
    @notifiable = notifiable
    @action = action
  end

  def perform
    ActiveRecord::Base.transaction do
      center.managers.each do |manager|
        notification = Notification.create! recipient: manager, action: action,
          notifiable: notifiable
      end
    end
  end
end

class Notification::NotifyCenterManagersService
  attr_reader :center, :notifiable, :action, :creater, :creatable

  def initialize center, notifiable, creatable, action, creater
    @center = center
    @notifiable = notifiable
    @creatable = creatable
    @action = action
    @creater = creater
  end

  def perform
    ActiveRecord::Base.transaction do
      center.managers.each do |manager|
        notification = Notification.create! recipient: manager, notifiable: notifiable,
          action: action, user: creater, creatable: creatable
      end
    end
  end
end

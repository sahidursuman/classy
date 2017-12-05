FactoryBot.define do
  factory :notification do
    recipient_id 1
    action 1
    notifiable nil
    is_read false
  end
end

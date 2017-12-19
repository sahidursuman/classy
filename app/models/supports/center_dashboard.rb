class Supports::CenterDashboard
  attr_reader :center

  def initialize center
    @center = center
  end

  def page_views_statistics
    (1..10).to_a.reverse.inject({days: [], views: []}) do |result, i|
      selected_time = i.days.ago
      result[:days] << selected_time.to_date
      result[:views] << center.impressionist_count(filter: :session_hash,
        start_date: selected_time.beginning_of_day, end_date: selected_time.end_of_day)
      result
    end
  end
end

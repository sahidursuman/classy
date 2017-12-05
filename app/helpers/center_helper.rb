module CenterHelper
  def center_sort_options
    Center::SORT_OPTIONS.map {|option| [t(".#{option}"), option]}
  end
end

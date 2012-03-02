module MomentsHelper

  def decade_button(d)
    full_year = "#{d}-1-1"
    total = Moment.where(:datapoint => (full_year.to_date)..(full_year.to_date.advance(:years => 9).end_of_year)).count
    unless total <= 0
      link_to("#{d}s", moments_path(:decade => d)) + " (#{total})"
    else
      "#{d}s (#{total})"
    end
  end

  def year_button(year = '1963')
    full_year = "#{year}-1-1"
    decade = year.to_s.truncate(2).to_i * 10
    total = Moment.where(:datapoint => (full_year.to_date)..(full_year.to_date.end_of_year)).count
    unless total <= 0
      link_to("#{year}", moments_path(:decade => decade, :year => year)) + " (#{total})"
    else
      "#{year} (#{total})"
    end
  end

end

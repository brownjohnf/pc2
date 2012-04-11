module MomentsHelper

  def decade_link(d)
    full_year = "#{d}-1-1"
    total = Moment.where(:datapoint => (full_year.to_date)..(full_year.to_date.advance(:years => 9).end_of_year)).count
    unless total <= 0
      link_to("#{d} (#{total})", moments_path(:decade => d))
    else
      link_to("#{d} (#{total})", moments_path(:decade => d))
    end
  end

  def year_link(year = '1963')
    full_year = "#{year}-1-1"
    decade = year.to_s.truncate(2).to_i * 10
    total = Moment.where(:datapoint => (full_year.to_date)..(full_year.to_date.end_of_year)).count
    unless total <= 0
      link_to("#{year} (#{total})", moments_path(:year => year))
    else
      link_to("#{year} (#{total})", moments_path(:year => year))
    end
  end

end

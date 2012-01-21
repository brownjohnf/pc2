module MomentsHelper

  def decade_button(d = '1960')
    full_year = "#{d}-1-1"
    total = Moment.where(:datapoint => (full_year.to_date)..(full_year.to_date.advance(:years => 9).end_of_year)).count
    button_to "#{d}s (#{total})", decade_moment_path(d), :method => :get, :disabled => ((total < 0) ? true : false)
  end

  def year_button(year = '1963', disabled = 'false')
    full_year = "#{year}-1-1"
    total = Moment.where(:datapoint => (full_year.to_date)..(full_year.to_date.end_of_year)).count
    button_to "#{year} (#{total})", year_moment_path(year), :method => :get, :disabled => ((total == 0) ? true : false)
  end

end

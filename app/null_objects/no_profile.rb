class NoProfile

  def real_age
  end

  %i(birth_date age season_id char_id points place beast person phisics look bio character items other comment).each { |ali| alias_method ali, :real_age }

end
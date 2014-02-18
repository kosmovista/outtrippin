module ItinerariesHelper
  def get_date_options(quantity)
    options = ["Haven't decided"]
    now = Time.now
    time = Time.utc(now.year, now.month, 1, 0, 0, 0)

    quantity.times do
      options << time.strftime("%B") + ", " + time.year.to_s
      time = time .advance(months: 1)
    end

    return options
  end

  def activity_budget_options
    ['$0-50', '$50-100', '$100-200', '$200+']
  end

  def accommodation_budget_options
    ['$0-50', '$50-100', '$100-200', '$200-500', '$500+']
  end

  def expanded_sidebar
    content_for :body do
      "<script>window.showSidebar();</script>".html_safe
    end
  end

    def full_pitch
    content_for :body do
      "<script>window.showPitch();</script>".html_safe
    end
  end

  # helpers for step bar  ##########################
  def steps
    %w(describe launch pick book)
  end

  def left_bar_or_space(index, steps)
    return "&nbsp;" if (index == 1)
    "<hr />"
  end

  def right_bar_or_space(index, steps)
    return "&nbsp;" if (index == steps.length)
    "<hr />"
  end
  ##################################################

 # helpers for step bar  ##########################
  def expert_steps
    ['Submit a pitch', 'The requestor picks a winner', 'Winner writes the story']
  end

  def left_bar_or_space(index, steps)
    return "&nbsp;" if (index == 1)
    "<hr />"
  end

  def right_bar_or_space(index, steps)
    return "&nbsp;" if (index == steps.length)
    "<hr />"
  end
  ##################################################

  def expert_info_website_url(website)
    "http://" + website
  end

  def expert_info_twitter_url(handle)
    "http://twitter.com/" + handle
  end

  def expert_info_instagram_url(handle)
    "http://instagram.com/" + handle
  end

  def pitches_so_far(itinerary)
    return "No pitches in so far" if itinerary.pitches.nil?
    itinerary.pitches.count == 1 ? "1 pitch in so far." : "#{itinerary.pitches.count} pitches in so far."
  end

end

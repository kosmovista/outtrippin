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

  def budget_options
    ['$50-100', '$100-200', '$200-500','$500+']
  end

  def expanded_sidebar
    content_for :body do
      "<script>window.showSidebar();</script>".html_safe
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
end

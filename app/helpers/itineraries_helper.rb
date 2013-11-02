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
end

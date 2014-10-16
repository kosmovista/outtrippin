module Chargeable
  extend ActiveSupport::Concern

  def charge(token, plan)
    if plan == "Single"
      customer = Stripe::Customer.create(
        :card => token,
        :plan => plan,
        :email => self.user.email
      )
    else
      charge = Stripe::Charge.create(
        :amount => self.price_in_cents(plan),
        :currency => "usd",
        :card => token,
        :description => self.user.email
      )
    end
  end

  def price(plan)
    self.duration.to_i * plan
  end

  def price_in_cents(plan)
    return (self.price(plan) * 100).to_i
  end

  # def apply_discount(coupon)
  #   self.discount = coupon.percent_off
  #   self.save
  #   coupon.was_redeemed
  # end
end

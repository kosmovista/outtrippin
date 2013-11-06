module Chargeable
  extend ActiveSupport::Concern

  def charge(token)
    charge = Stripe::Charge.create(
      :amount => self.price_in_cents,
      :currency => "usd",
      :card => token,
      :description => self.user.email
    )
  end

  def price
    self.duration.to_i * 10
  end

  def price_in_cents
    return (self.price * 100).to_i
  end

  # def apply_discount(coupon)
  #   self.discount = coupon.percent_off
  #   self.save
  #   coupon.was_redeemed
  # end
end

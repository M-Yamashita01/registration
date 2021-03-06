class AdditionalPayment < ApplicationRecord
  belongs_to :user_event
  validates :category, presence: true
  validates :description, presence: true
  validates :market_price, presence: true
  validates :payment_price, presence: true
  validates :payment_id, :presence => true, :if => :payment_amount

  def formatted_payment_date
    payment_date&.strftime(Session::DATETIME_FORMAT)
  end

  def price
    payment_price
  end

  def unpaid?
    payment_amount.nil?
  end

  def donation?
    charitable_donation? && donation_amount > 0
  end

  def donation_amount
    donation = 0
    if charitable_donation? && market_price.to_i < payment_amount.to_i
      donation = payment_amount - market_price
    end
    donation
  end

  def long_description
    "#{user_event.name} (#{category}): #{description}"
  end

end

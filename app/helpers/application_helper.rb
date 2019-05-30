module ApplicationHelper

  def admin?
    user_signed_in? and current_user.admin?
  end

  def event_host?
    host = false
    if user_signed_in?
      unless @event.nil?
        current_user.event_hosts.each do |hosted_event|
          event = hosted_event.event
          if hosted_event.active?
            host = host || (event.id == @event.id)
          end
        end
      end
    end
    host || admin?
  end


  def yes_no (value)
    value ? "Yes" : "No"
  end

  def receipts_exist?
    current_user.user_events.any? {|user_event| user_event.total_price > 0}
  end

  def unpaid_payments?
    current_user.user_events.any? {|user_event| user_event.additional_payments.any? {|payment| payment.unpaid?}}
  end

  def pending_payments
    unpaid_payments = []
    current_user.user_events.each do |user_event|
      user_event.additional_payments.each do |payment|
        if payment.unpaid?
          unpaid_payments << payment
        end
      end
    end
    unpaid_payments
  end

  def self_select_allowed?
    allowed = false
    @event.sessions.each do |session|
      session.tables.each do |table|
        allowed |= table.gm_self_select?
      end
    end
    allowed
  end

  def online_sales_closed?
    @event.online_sales_closed?
  end
end


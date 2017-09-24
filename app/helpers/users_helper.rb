module UsersHelper
  def number_order(num)
    "##{num+10000000}"
  end

  def format_mdate(dt)
    #dt.strftime("%Y-%m-%d")
    dt
  end

  def format_status(status)
    case status
    when 'in_progress'
      'In Progress'
    when 'in_queue'
      'In Queue'
    when 'in_delivery'
      'In Delivery'
    when 'delivered'
      'Delivered'
    when 'canceled'
      'Canceled'
    else
      status
    end
  end
end

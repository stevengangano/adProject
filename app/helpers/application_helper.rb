module ApplicationHelper
  def alerts
    alert = (flash[:alert] || flash[:error] || flash[:notice])

    if alert
      alert_generator alert
    end
  end

  def alert_generator msg
    js extend_gritter(msg, position: :top_left)
    js add_gritter(msg, title: "Ad Project", sticky:false, time: 1000)

  end
end

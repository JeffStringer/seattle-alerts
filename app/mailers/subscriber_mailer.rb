class SubscriberMailer < ActionMailer::Base
  default from: "from@example.com"

  def admin_email(subscriber_id)
    @subscriber = Subscriber.find(subscriber_id)

    mail(from: "Seattle Alerts <jeff.j.stringer@gmail.com>", to: "jeff.j.stringer@gmail.com", subject: "New Subscriber") do |format|
      format.html 
      format.text
    end   
  end

  def signup_email(subscriber_id)
    @subscriber = Subscriber.find(subscriber_id)

    mail(to: @subscriber.email, from: "Seattle Alerts <jeff.j.stringer@gmail.com>", subject: "Welcome to Seattle Alerts") do |format|
      format.html 
      format.text
    end   
  end

  def update_email(subscriber_id)
    @subscriber = Subscriber.find(subscriber_id)

    mail(to: @subscriber.email, from: "Seattle Alerts <jeff.j.stringer@gmail.com>", subject: "Account Updated") do |format|
      format.html 
      format.text
    end   
  end

  def notification_email(police_notifications, fire_notifications, subscriber)
    @subscriber = subscriber
    @police_alerts = []
    @fire_alerts = []

    filter_police_alerts(police_notifications, fire_notifications, subscriber)
    filter_fire_alerts(police_notifications, fire_notifications, subscriber)

    mail(to: subscriber.email, from: "Seattle Alerts <jeff.j.stringer@gmail.com>", subject: "Activity Occurred in Your Area") do |format|
      format.html 
      format.text
    end
  end

  private

    def filter_police_alerts(police_notifications, fire_notifications, subscriber)
      unless police_notifications.nil?
        police_notifications.each do |p_n|
          @police_alerts << p_n.police_alert if p_n.subscriber_id == subscriber.id
        end
        @police_alerts.sort_by! { |p| p[:time_show] }
        @police_alerts.slice!(0,30) if @police_alerts.length >= 30
        @police_alerts.reverse!
      end
    end

    def filter_fire_alerts(police_notifications, fire_notifications, subscriber)
      unless fire_notifications.nil?
        fire_notifications.each do |f_n|
          @fire_alerts << f_n.fire_alert if f_n.subscriber_id == subscriber.id
        end
        @fire_alerts.sort_by! { |f| f[:time_show] }
        @fire_alerts.slice!(0,15) if @fire_alerts.length >= 30
        @fire_alerts.reverse!
      end
    end
end

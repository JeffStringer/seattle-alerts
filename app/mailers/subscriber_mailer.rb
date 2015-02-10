class SubscriberMailer < ActionMailer::Base
  default from: "from@example.com"

  def subscriber_email(subscriber)
    @subscriber = subscriber

    mail(from: "Seattle Alerts <jeff.j.stringer@gmail.com>", to: "jeff.j.stringer@gmail.com", subject: "New Subscriber") do |format|
      format.html 
      format.text
    end   
  end

  def signup_email(subscriber)
    @subscriber = subscriber

    mail(to: subscriber.email, from: "Seattle Alerts <jeff.j.stringer@gmail.com>", subject: "Welcome to Seattle Alerts") do |format|
      format.html 
      format.text
    end   
  end

  def notification_email(police_notifications, fire_notifications, subscriber)
    @subscriber = subscriber
    @police_alerts = []
    @fire_alerts = []

    unless police_notifications.nil?
      police_notifications.each do |p_n|
        @police_alerts << p_n.police_alert if p_n.subscriber_id == subscriber.id
      end
    end

    unless fire_notifications.nil?
      fire_notifications.each do |f_n|
        @fire_alerts << f_n.fire_alert if f_n.subscriber_id == subscriber.id
      end
    end

    mail(to: subscriber.email, from: "Seattle Alerts <jeff.j.stringer@gmail.com>", subject: "Activity Occurred in Your Area") do |format|
      format.html 
      format.text
    end
  end
end

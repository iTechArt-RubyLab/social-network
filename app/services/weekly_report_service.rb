# frozen_string_literal: True

# Service responsible for compiling a weekly user report
class WeeklyReportService
  WEEK_AGO = 1.week.ago.utc

  def initialize(user)
    @user = user
  end

  def weekly_report
    { subscriptions: weekly_subscriptions, subscribers: weekly_subscribers }
  end

  private

  def weekly_subscriptions
    @user.subscriptions.where('user_subscriptions.created_at >= ?', WEEK_AGO).order('created_at DESC')
  end

  def weekly_subscribers
    @user.subscribers.where('user_subscriptions.created_at >= ?', WEEK_AGO).order('created_at DESC')
  end
end

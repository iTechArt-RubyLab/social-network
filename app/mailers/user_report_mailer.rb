# frozen_string_literal: true

require Rails.root.join('app', 'services', 'weekly_report_service.rb')

# User report mailer class
class UserReportMailer < ApplicationMailer
  def weekly_report_mailer
    @user = User.find(params[:user_id])
    @weekly_report = WeeklyReportService.new(@user).weekly_report
    mail(to: @user.email, subject: 'Weekly report!')
  end
end

# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_report_mailer
class UserReportMailerPreview < ActionMailer::Preview
  def weekly_report_mailer
    UserReportMailer.with(user_id: 340).weekly_report_mailer
  end
end

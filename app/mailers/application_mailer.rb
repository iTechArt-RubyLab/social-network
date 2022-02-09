# frozen_string_literal: true

# Base mailer class
class ApplicationMailer < ActionMailer::Base
  default from: 'SocialNetwork <socialnetworkteam.contact@gmail.com>'
  layout 'mailer'
end

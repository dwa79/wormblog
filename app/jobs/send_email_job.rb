class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    @user = user
    
  end
end

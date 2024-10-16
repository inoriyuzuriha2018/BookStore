class HardJob
  include Sidekiq::Job
  sidekiq_options :retry => 3

  sidekiq_retries_exhausted do |job, ex|
    Sidekiq.logger.warn "Failed #{job['class']} with #{job['args']}: #{job['error_message']}"
  end

  def perform(user_id = 1, *args)
    user = User.find(user_id)
    UserMailer.welcome_email(user).deliver_now
    raise "Mail dont send to user!"
  end
end

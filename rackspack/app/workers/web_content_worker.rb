class WebContentWorker
  include Sidekiq::Worker

  def perform(id)
    Member.wrap_web_content(id)
  end
end
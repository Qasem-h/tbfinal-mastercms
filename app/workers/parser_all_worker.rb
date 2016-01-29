class ParserAllWorker
  include Sidekiq::Worker
  
  sidekiq_options retry: false
  
  def perform
    ParserAll.run
  end
end
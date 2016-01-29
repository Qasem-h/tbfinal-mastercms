class ParserPastScoreWorker
  include Sidekiq::Worker
  
  sidekiq_options retry: false
  
  def perform
    ScoreParser.execute("d-1")
  end
end
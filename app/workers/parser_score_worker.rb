class ParserScoreWorker
  include Sidekiq::Worker
  
  sidekiq_options retry: false
  
  def perform
    ScoreParser.execute("livescore")
  end
end
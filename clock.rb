require './config/boot'
require './config/environment'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end
  
  every(6.hours, 'import_leagues') { ParserAllWorker.perform_async }
  every(3.hours, 'import_previous_livescore') { ParserPastScoreWorker.perform_async }
  every(15.minutes, 'import_current_livescore') { ParserScoreWorker.perform_async }
end
web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -C config/sidekiq.yml -e production
clock: bundle exec clockwork clock.rb
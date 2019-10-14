namespace :twitter do
  desc "Tweets last post from '/r/tiodopave' to '@paveoupacumer' twitter account"
  task fire_tweet: :environment do
    question, answer = Api::Reddit::Tiodopave.new.get_newest_post.values
    twitter_bot = TwitterBot.new("#{question}\n\n#{answer}")

    Rails.logger.info "=== Running task: \'twitter:fire_tweet\'"
    twitter_bot.fire_tweet
  end
end

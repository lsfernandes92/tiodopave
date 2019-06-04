namespace :twitter do
  desc "Tweets last post from '/r/tiodopave' to '@paveoupacumer' twitter account"
  task fire_tweet: :environment do
    question, answer = RedditApi::TiodopaveService.new.get_newest_post.values
    twitter_bot = TwitterBot.new("#{question}\n\n#{answer}")

    Rails.logger.info "=== Running task: \'twitter:fire_tweet\'"
    if twitter_bot.already_tweet?
      Rails.logger.warn "!!! Post already tweeted..."
      Rails.logger.warn "!!! Skiping tweeting..."
    else
      twitter_bot.fire_tweet
      Rails.logger.info "=== Tweet successfully!"
    end
  end
end

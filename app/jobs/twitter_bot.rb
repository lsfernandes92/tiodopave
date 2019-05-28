class TwitterBot
  def initialize
    @twitter_service = TwitterApi::PaveoupacumerService.new(post)
  end

  def post
    RedditApi::TiodopaveService.new.get_newest_post[:title]
  end

  def already_tweet?
    @twitter_service.last_posted_tweet.include?(post)
  end

  def fire_tweet
    @twitter_service.tweet
  end
end

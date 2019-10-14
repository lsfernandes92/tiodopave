class TwitterBot
  def initialize(post)
    @post = post
  end

  def fire_tweet
    if already_tweet?
      Rails.logger.warn "!!! Post already tweeted..."
      Rails.logger.warn "!!! Skiping tweeting..."
    else
      Api::Twitter::Paveoupacumer.tweet(@post)
      Rails.logger.info "=== Tweet successfully!"
    end
  end

    private

    def already_tweet?
      Api::Twitter::Paveoupacumer.last_posted_tweet.include?(@post)
    end
end

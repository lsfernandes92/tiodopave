module Api::Reddit
  class Tiodopave
    BASE_URL = 'https://www.reddit.com'
    BASE_OAUTH_URL = 'https://oauth.reddit.com'

    def get_newest_post(options = 'limit=1')
      get = Api::Twitter::Paveoupacumer.get(
        "#{BASE_OAUTH_URL}/r/tiodopave/new.json?#{options}",
        gather_access_token
      )

      {
        "title" => get.dig("data", "children", 0, "data", "title"),
        "selftext" => get.dig("data", "children", 0, "data", "selftext")
      }
    end

    def gather_access_token
      Api::Twitter::Paveoupacumer.post(
        "#{BASE_URL}/api/v1/access_token",
        payload,
        headers
      )["access_token"]
    end

      private

      def payload
        {
          "grant_type": "password",
          "username": ENV["REDDIT_USERNAME"],
          "password": ENV["REDDIT_PASSWORD"]
        }
      end

      def headers
        {
          :user_agent => "PaveoupacumerClient by 1gContem",
          :accept => "application/json",
          :content_type => "application/json"
        }
      end
  end
end

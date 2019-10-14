class RestClientAdapter
  def self.get(path, access_token)
    begin
      response = RestClient.get(
        path,
        { :Authorization => "Bearer #{access_token}" }
      )

      json_parse(response)
    rescue RestClient::ExceptionWithResponse => e
      logger.error "%%% Something went wrong in request post"
      logger.error "%%% It fails with error: #{e.http_code}"
      logger.error "%%% And with message: #{e.message}"

      { "message" => e.message, "error" => e.http_code }
    end
  end

  def self.post(path, payload, headers)
    response = RestClient::Request.execute(
      :method => :post,
      :url => path,
      :user => ENV["REDDIT_TIODOPAVE_APP_ID"],
      :password => ENV["REDDIT_TIODOPAVE_APP_SECRET"],
      :payload => payload,
      :headers => headers
    )

    json_parse(response)
  end

    private

    def json_parse(response)
      JSON.parse(response.body)
    end
end

require 'rails_helper'

RSpec.describe RedditApi::TiodopaveService do
  describe '#get_newest_post' do
    context 'when authorized' do
      let(:get_response) {
        {
          "data" => {
            "children" => [
              "data" => {
                "title" => 'Do I wanna know?',
                "selftext" => 'Of course you do'
              }
            ]
          }
        }
      }
      let(:response) {
        {
          "title" => 'Do I wanna know?',
          "selftext" => 'Of course you do'
        }
      }

      before do
        allow_any_instance_of(RedditApi::TiodopaveService)
          .to receive(:get)
          .and_return(get_response)
      end

      it 'returns the newest post' do
        expect(subject.get_newest_post).to eq response
      end
    end

    context 'when not authorized' do
      let(:get_response) { { "title"=>nil, "selftext"=>nil } }

      before do
        allow_any_instance_of(RedditApi::TiodopaveService)
          .to receive(:get)
          .and_return(get_response)
      end

      it 'returns status code 401 Unauthorized' do
        expect(subject.get_newest_post).to eq get_response
      end

    end
  end

  describe '#gather_access_token' do
    context 'when request with correct information' do
      let(:post_response) {
        {
          "access_token" => "UMT0K3NM4R0T0",
          "token_type" => "bearer",
          "expires_in" => 3600,
          "scope" => "*"
        }
      }

      before do
        allow_any_instance_of(RedditApi::TiodopaveService)
          .to receive(:post)
          .and_return(post_response)
      end

      it 'returns the access token successfully' do
        expect(subject.gather_access_token).to eq "UMT0K3NM4R0T0"
      end
    end
  end
end

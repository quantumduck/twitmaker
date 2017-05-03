class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      format.html do
        if @tweet.save
          respond_to
          if request.xhr?
            render partial: "tweet", locals: {tweet: @tweet}
          else
            redirect_to tweets_path
          end
        else
          render :index
        end
      end
      format.json do
        render plain: 'json!'
      end

    end


  end

  def destroy
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end
end

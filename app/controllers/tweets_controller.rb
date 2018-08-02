class TweetsController < ApplicationController

  # get '/:username/tweets' do
  #   @user = User.find_by_slug(params['username'])
  #   erb :'/tweets/tweets'
  # end

  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session['user_id'])

      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do

    if params['content'] != ""
      @tweet = Tweet.create(params)
      @tweet.user_id = session['user_id']
      @tweet.save
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params['id'])

    if logged_in?
      erb :"tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params['id'])

    if logged_in?
      erb :"tweets/edit"
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do

    if params['content'] != ""
      binding.pry
      @tweet = Tweet.find_by_id(params['id'])
      @tweet.content = params['content']
      @tweet.save
      redirect "/tweets/#{@tweet.id}/edit"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    binding.pry
    if logged_in?
      @tweet = Tweet.find_by_id(params['id'])
      @tweet.delete

    else
      redirect '/login'

    end


  end











end

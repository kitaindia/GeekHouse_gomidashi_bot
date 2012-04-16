#encoding: UTF-8
class ContentsController < ApplicationController
  before_filter :init

  def index
    @tasks = Task.find_all_by_who(current_user.name) if current_user
    @tasks_forMe = Task.find_all_by_for(current_user.name) if current_user
    @task = Task.new

    @mem_list = Member.order('jyunban_id')
    @member = Member.find_by_jyunban_id(1)
    @tweet =Tweet.find_by_week(Time.now.strftime("%a"))


  end

  def init
    redirect_to(:controller => 'members') and return if Member.count == 0
    redirect_to(:controller => 'tweets') and return if Tweet.count == 0 or Tweet.find_by_week(Time.now.strftime("%a")) == nil
  end


  def roll
    count = Member.count
    Member.all.each do |member|
      if member.jyunban_id == 1
        member.jyunban_id = count
      else
        member.jyunban_id -= 1
      end
      member.save
    end
    redirect_to :action => 'index'
  end

  private
  def self.daily_tweet
    @member = Member.find_by_jyunban_id(1)

    @tweet =Tweet.find_by_week(Time.now.strftime("%a"))
    tweet = "@#{@member.user} さん、#{@tweet.message}"
    if Time.now.strftime("%a") == "Sat"
      member_next = Member.find_by_jyunban_id(2)
      tweet = tweet + "明日から @#{member_next.user} さんが当番よ。よろしくね"
    end

    tweet =tweet +"['any hashtag']"

    update(tweet)
  end

  def self.update(tweet)
    return nil unless tweet

    begin
      Twitter.update(tweet.chomp)
    rescue => ex
      nil
    end
  end

  def self.rolling
    count = Member.count
    Member.all.each do |member|
      if member.jyunban_id == 1
        member.jyunban_id = count
      else
        member.jyunban_id -= 1
      end
      member.save
    end
  end
end

class UsersController < ApplicationController
  require 'net/http'
  require 'uri'
  def index
    @users = User.all
  end

  def get_scores
    begin
      uri = URI.parse("https://www.lpga.com/tournaments/volvik-founders-cup/results?filters=2019&archive=")
      response = Net::HTTP.get_response()
      @status = create_records(Nokogiri::HTML.parse(response.body))
      @users = User.all
    rescue Exception => e
    end
  end

  def create_records(parse_data)
    begin
      parse_data.search('.body').each do |data|
        name = data.search('.player-name').first.content
        score = data.search('.scores').first.content.gsub(/\s/,'')
        User.create!(name: name, scores: score)
      end
      return true
    rescue Exception => e
      return false
    end
  end

  def destroy_all
    User.delete_all
  end
end


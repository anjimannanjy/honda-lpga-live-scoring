class UsersController < ApplicationController
  require 'net/http'
  require 'uri'
  def index
    @users = User.all
  end

  def get_scores
    begin
      uri = URI.parse("https://www.lpga.com/tournaments/volvik-founders-cup/results?filters=2019&archive=")
      response = Net::HTTP.get_response(uri)
      @status = create_records(Nokogiri::HTML.parse(response.body))
      @users = User.all
    rescue Exception => e
    end
  end

  def create_records(parse_data)
    begin
      parse_data.search('.player-dropdown-wrapper').each_with_index do |data,index|
        name = data.search('.player-name').first.content
        scores = parse_data.search('.scores')[index].content.gsub(/\s/,'')
        static_url = data.search('.player-data-container')[0].values[1]
        res = Net::HTTP.get_response(URI.parse("https://www.lpga.com#{static_url}"))
        parse_data1 = Nokogiri::HTML.parse(res.body)
        par = parse_data1.search('.body')[0].content.squish!
        round = parse_data1.search('.body')[1].content.squish!
        status = parse_data1.search('.body')[2].content.squish!
        User.create!(name: name, scores: scores, par: par, round: round, status: status)
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


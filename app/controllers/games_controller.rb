require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }.to_a
  end

  def included?
    params[:score].chars.all? { |letter| params[:score].count(letter) <= params[:letters].count(letter) }
  end

  def score
    @score = (params[:score] || "").upcase
    if included?
      if english_word?(params[:score])
        @score = true
        return @score
      end
    end
  end

  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end

require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def home

  end

  def new
    @letters_sample = []
    @letters = ("A".."Z").to_a
    10.times do
      @letters_sample << @letters.sample
    end

  end

  def score
    @letters = params[:letters_sample].split
    @word = params[:word]
    # raise
    @valid_grid = valid_grid()
    @english = english_word()
    if @valid_grid == false
      @message = "Sorry but #{@word} can't be built out of #{@letters.split(",")}"
    else
      if @english == false
        @message = "Sorry but #{@word} does not seem to be a valid English word..."
      else
          @message = "Congratulations! #{@word} is a valid English word!"
      end
    end
  end

  private

  def valid_grid
    @word.chars.all? do |letter|
      @word.chars.count(letter) <= @letters.count(letter)
    end
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = URI.open(url)
    json = JSON.parse(user_serialized.read)
    return json["found"]
  end
end

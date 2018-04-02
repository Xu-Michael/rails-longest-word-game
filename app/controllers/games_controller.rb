require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("a".."z").to_a.sample.upcase;
    end
    @start_time = Time.now
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def compute_score(attempt, time_taken)
    time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def score
    word = params[:word].upcase
    @letters = params[:letters].split(' ')
    if included?(word, @letters)
      if english_word?(word)
        score = compute_score(word, params[:time].to_f)
        @message = [score.round, "Well done!"]
      else
        @message = [0, "Sorry but #{word} is not an english word."]
      end
    else
      @message = [0, "Sorry but #{word} can't be built out of the above letters."]
    end
  end
end

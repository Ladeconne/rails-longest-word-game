require 'pry-byebug'
require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      new_letter = ('a'..'z').to_a.sample.upcase
      @letters << new_letter
    end
  end

  def score
    @word = params[:word].upcase
    @letters = params[:grid].split(" ")
    @score = 0
    # Iterate through each letter of the @word
    @word.split("").each do |word_letter|
    # If letter == word_letter remove word_letter from @letters
      if @letters.find_index(word_letter)
        @letters.delete_at(@letters.find_index(word_letter))
      else
        return @control = "Not in letters"
      end
    end
    @score += @word.length
    # Make a GET request to the API
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = URI.open(url).read
    data = JSON.parse(response)
    valid_word = data["found"]
    if valid_word == true
      @control = "Congrats"
    else
      @control = "Does not exist"
    end
  end
end

require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    grid_size = 10
    alphabet = [*'A'..'Z']
    @letters = grid_size.times.map { alphabet.sample }
  end

  def score
    @guess = params[:guess].upcase
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    @included = included?(@guess, @letters)
    @english = english?(url)
  end

  private

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english?(url)
    open = open(url).read
    json = JSON.parse(open)
    json['found']
  end
end

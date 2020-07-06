class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @attempt = params[:answer]
    @grid = params[:grid].split(" ")
    @included = letters_within_grid?(@attempt, @grid)
    @english_word = english_word?(@attempt)
  end

private

  def letters_within_grid?(attempt, grid)
    attempt.upcase.chars.all? { |letter| grid.include?(letter) && attempt.count(letter) <= grid.count(letter) }
  end

  def english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    attempt_online_check = JSON.parse(open(url).read)
    return attempt_online_check["found"]
  end
end

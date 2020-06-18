class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    attempt = params[:answer]
    grid = params[:grid].split(" ")
    if !letters_within_grid?(attempt, grid)
      @answer = "Sorry but #{attempt.upcase} can't be built out of #{grid}"
    elsif !english_word?(attempt)
      @anwer = "Sorry but #{attempt.upcase} does not seem to be a valid English word..."
    else
      @answer = "Congratulations! #{attempt.upcase} is a valid English word!"
    end
  end

  def letters_within_grid?(attempt, grid)
    attempt.upcase.chars.all? { |letter| grid.include?(letter) && attempt.count(letter) <= grid.count(letter) }
  end

  def english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    attempt_online_check = JSON.parse(open(url).read)
    return attempt_online_check["found"]
  end
end

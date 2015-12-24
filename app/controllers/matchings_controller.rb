class MatchingsController < ApplicationController
  def index
  end

  def sort
    @men = params['mans'].reject(&:blank?)
    @women = params['womans'].reject(&:blank?)

    if @men.count != @women.count
      error_msg = 'Invalid input size. Number of men and women must be same.'
      flash[:notice] = error_msg
      redirect_to matchings_path
    end

    if @men.count == 0
      error_msg = 'Please input at least one man and woman.'
      flash[:notice] = error_msg
      redirect_to matchings_path
    end
  end

  def calc
    men = params['mans']
    women = params['womans']

    stable_matching = StableMatchingModel.new(men, women)
    @engage_list = stable_matching.calc
    render
  end
end
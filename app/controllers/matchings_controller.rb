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

    if @men.count <= 1
      error_msg = 'Please input at least two pair of man and woman.'
      flash[:notice] = error_msg
      redirect_to matchings_path
    end
  end

  def calc
    stable_matching = StableMatchingModel.new(params['mans'], params['womans'])
    @engage_list = stable_matching.match
    render
  end
end

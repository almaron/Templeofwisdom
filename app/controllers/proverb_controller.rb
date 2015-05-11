class ProverbController < ApplicationController

  layout false

  def show
    render text: @proverb = random_proverb
  end

  private

  def random_proverb
    proverb_array.sample
  end

  def proverb_array
    File.readlines(Rails.root.join('public','pros.txt')).map {|line| line.gsub("\r\n",".")}
  end

end

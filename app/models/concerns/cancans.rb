module Cancans
  extend ActiveSupport::Concern

  CANCANS = %i(view_hidden moderate_forum)

  CANCANS.each do |can|
    define_method "can_#{can}?" do
      cancans[can] > 0 || is_in?([:admin, :master])
    end
  end

  def cancans
    Hash[CANCANS.zip cancan.digits(CANCANS.size)]
  end

  def cancans=(can_hash)
    string = ''
    CANCANS.reverse.map { |key| string += can_hash[key].to_s }
    self.cancan = string.to_i
  end

end

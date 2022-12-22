class Number < ApplicationRecord
  before_save :summation

  def summation
    numberA + numberB
  end
end

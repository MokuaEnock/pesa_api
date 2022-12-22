class Number < ApplicationRecord
  before_save :summation

  def summation
    self.sum = numberA + numberB
  end
end

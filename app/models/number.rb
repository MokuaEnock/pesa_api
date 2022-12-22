class Number < ApplicationRecord
  before_save :summation, :differ

  def summation
    self.sum = numberA + numberB
  end

  def differ
    if numberA > numberB
      self.difference = numberA - numberB
    else
      self.difference = numberB - numberA
    end
  end
end

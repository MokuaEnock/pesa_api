class User < ApplicationRecord
  before_save :pay_mpesa

  def pay_mpesa
    
  end
end

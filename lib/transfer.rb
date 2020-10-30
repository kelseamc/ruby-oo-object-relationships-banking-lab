class Transfer
  require 'pry' 

class Transfer

  attr_accessor :amount, :status
  attr_reader :sender, :receiver
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  
  def execute_transaction
    if self.status == "complete" 
      return "rejected"
    elsif @sender.balance < @amount || @sender.status == "closed" || @receiver.status == "closed"
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
    # binding.pry
    @sender.balance -= @amount
    @receiver.balance += @amount
    self.status = "complete"
  end

  def reverse_transfer
    if self.status == "complete"
    @receiver.balance -= @amount
    @sender.balance += @amount
    self.status = "reversed"
    end
  end
end

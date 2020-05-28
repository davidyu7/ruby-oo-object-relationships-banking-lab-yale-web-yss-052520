class Transfer
  # your code here
  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize (sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if !self.valid?
      self.status = "rejected" 
      return "Transaction rejected. Please check your account balance."
    end
    if self.status == "pending"
      puts "shouldn't enter me"
      if self.sender.balance >= self.amount
        self.sender.balance -= self.amount
        self.receiver.balance += self.amount
        self.status = "complete"
      else
        self.status = "rejected"
      end
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      if self.receiver.balance >= self.amount
        self.sender.balance += self.amount
        self.receiver.balance -= self.amount
        self.status = "reversed"
      else
        "Receiver does not have sufficient funds to reverse transaction."
      end
      "This transaction has not been completed yet."
    end
  end

end

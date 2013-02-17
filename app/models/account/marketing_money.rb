class Account::MarketingMoney < ActiveRecord::Base
  self.table_name = 'marketing_money_account'

  has_one :owner, class_name: 'User'

  def load(amount)
    amount = amount.to_d
    old_balance = self.balance
    return errors.add(:balance, 'You cannot use a negative amount to load this account') if amount <= 0.00
    return errors.add(:limit,   'You cannot load this account beyond it\'s allowed limit' ) if amount > limit
    return errors.add(:limit,   'The load operation is causing to hit your limit threshold. Try a lower amount') if (old_balance += amount) > limit
    self.balance += amount
    self.save
  end

  def withdraw(amount)
    amount = amount.to_d
    old_balance = self.balance
    return errors.add(:limit,   'Withdraw\'s more than the account limits are not allowed') if amount > limit
    return errors.add(:balance, 'You cannot use a negative or 0.00 amount to withdraw from this account') if amount <= 0.00
    return errors.add(:limit,   'Insufficient Funds: Cannot withdraw' ) if amount > old_balance
    self.balance -= amount
    self.save
  end

end
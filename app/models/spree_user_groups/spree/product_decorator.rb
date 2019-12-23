module SpreeUserGroups::Spree::ProductDecorator
  def price_for_user(user, currency = nil)
    self.master.price_for_user(user, currency)
  end
end

::Spree::Product.prepend SpreeUserGroups::Spree::ProductDecorator

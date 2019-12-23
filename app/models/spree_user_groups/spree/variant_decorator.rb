module SpreeUserGroups::Spree::VariantDecorator
  include ActionView::Helpers

  def price_for_user(user, currency = nil)
    default_price = price_in(currency)
    if user && user.user_group
      user.user_group.price_for_variant(self, default_price) || default_price
    else
      default_price
    end
  end

  def price_in(currency)
    @price_in ||= {}
    return @price_in[currency] if @price_in[currency]

    currency ||= Spree::Config[:currency]
    price = prices.select{ |price| price.currency == currency }.first || Spree::Price.new(variant_id: self.id, currency: currency)
    new_amount = price.amount

    if Spree::User.current && Spree::User.current.user_group
      price_for_user = Spree::User.current.user_group.price_for_variant(self, price)
      new_amount = price_for_user if price_for_user
    end

    # This line caused exception in old version. Variant_id can not be nil.
    @price_in[currency] = Spree::Price.new(variant_id: self.id, amount: new_amount, currency: currency)
  end
end

::Spree::Variant.prepend SpreeUserGroups::Spree::VariantDecorator

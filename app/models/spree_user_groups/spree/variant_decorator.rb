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
end

::Spree::Variant.prepend SpreeUserGroups::Spree::VariantDecorator

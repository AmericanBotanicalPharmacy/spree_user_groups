Spree::CheckoutController.class_eval do
  before_action :verify_minimum_order

  private
  def before_address
    @order.bill_address ||= Spree::Address.default
    @order.ship_address ||= Spree::Address.default
  end

  def verify_minimum_order
    if @order.user_id then
      group = Spree::User.find(@order.user_id).user_group
      unless group.blank? then
        if group.minimum_order > @order.total then
          flash[:error] = Spree.t(:minimum_order_not_met, :amount => group.minimum_order)
          redirect_to :cart
        end
      end
    end
  end
end

ApplicationController.class_eval do
  before_action :set_current_user

  def set_current_user
    Spree::User.current = spree_current_user
  end
end


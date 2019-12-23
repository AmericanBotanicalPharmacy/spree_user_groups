module SpreeUserGroups::ApplicationControllerDecorator
  def self.included base
    base.class_eval do
      before_action :set_current_user
    end
  end

  def set_current_user
    Spree::User.current = spree_current_user
  end
end

::ApplicationController.prepend SpreeUserGroups::ApplicationControllerDecorator


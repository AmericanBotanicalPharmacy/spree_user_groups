module SpreeUserGroups::Spree::UserDecorator
  def self.prepended base
    base.extend(ClassMethods)
    base.class_eval do
      belongs_to :user_group
    end
  end
  
  module ClassMethods
    def current
      RequestStore.store[:user]
    end

    def current=(user)
      RequestStore.store[:user] = user
    end
  end
end

::Spree::User.prepend SpreeUserGroups::Spree::UserDecorator


module SpreeUserGroups::Spree::UserDecorator
  def self.prepended base
    base.extend(ClassMethods)
    base.class_eval do
      belongs_to :user_group
    end
  end
  
  module ClassMethods
    def current
      Thread.current[:user]
    end

    def current=(user)
      Thread.current[:user] = user
    end
  end
end

::Spree::User.prepend SpreeUserGroups::Spree::UserDecorator


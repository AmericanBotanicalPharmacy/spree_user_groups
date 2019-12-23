module SpreeUserGroups::Spree::UserDecorator
  def self.prepended base
    base.class_eval do
      belongs_to :user_group
    end
  end
  
  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
end

::Spree::User.prepend SpreeUserGroups::Spree::UserDecorator


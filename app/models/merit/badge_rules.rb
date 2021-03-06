# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize

      ## Test badge
      #grant_on 'users#show', badge: "test", to: :itself do |user|
      #  user.name == "Badger"
      #end

      # Welcome badge
      grant_on 'users#login', badge: "Benvingut!", to: :itself

      # First bought coupon
      grant_on 'bought_coupons#create', badge: "Comprador Novell", to: :user do |coupon|
        coupon.user.bought_coupons.count == 1
      end

      # 5 bought coupons
      grant_on 'bought_coupons#create', badge: "Comprador Compulsiu", to: :user do |coupon|
        coupon.user.bought_coupons.count == 5
      end

      # First anunci
      grant_on 'anuncis#create', badge: "Anunciant Novell", to: :user do |anunci|
        anunci.user.anuncis.count == 1
      end

      # 5 anuncis
      grant_on 'anuncis#create', badge: "Anunciant Expert", to: :user do |anunci|
        anunci.user.anuncis.count == 5
      end

      # First bid
      grant_on 'bids#create', badge: "Ganes de Treballar", to: :user do |bid|
        bid.user.bids.count == 1
      end

      # 5 bids
      grant_on 'bids#create', badge: "Treballador Compulsiu", to: :user do |bid|
        bid.user.bids.count == 5
      end

    end
  end
end

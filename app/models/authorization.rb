class Authorization < ActiveRecord::Base
  belongs_to :user

  validates  :uid,      presence: true
  validates  :provider, presence: true
  validates  :user,     presence: true
  validates  :image,    presence: true

  class << self
    def from_omniauth(auth)
      where(auth.slice("uid", "provider")).first ||
      create_from_omniauth(auth)
    end

    private
    def create_from_omniauth(auth)
      user = User.where(email: auth["info"]["email"]).first_or_create
      user.authorizations.create(auth_params(auth))
    end

    def auth_params(auth)
      {
        "uid"      => auth["uid"],
        "provider" => auth["provider"],
        "image"    => auth["info"]["image"]
      }
    end
  end
end

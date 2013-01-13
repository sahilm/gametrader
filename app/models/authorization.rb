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
      user_from_omniauth(auth).authorizations.create(auth_params(auth))
    end

    def user_from_omniauth(auth)
      info = auth["info"]
      User.find_by(email: info["email"]) ||
      User.create(email: info["email"],
                  first_name: info["first_name"],
                  last_name: info["last_name"])
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

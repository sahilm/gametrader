class Authorization < ActiveRecord::Base
  belongs_to :user

  validates  :uid,      presence: true
  validates  :provider, presence: true
  validates  :user,     presence: true


  class << self
    def from_omniauth(auth)
      find_by(auth.slice("uid", "provider")) || create_from_omniauth(auth)
    end

    private
    def create_from_omniauth(auth)
      User.from_omniauth(auth).authorizations.create(auth_params(auth))
    end

    def auth_params(auth)
      {
        "uid"      => auth["uid"],
        "provider" => auth["provider"],
        "image"    => auth["info"]["image"] || auth["info"]["picture"]
      }
    end
  end
end

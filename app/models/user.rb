class User < ActiveRecord::Base
  has_many :authorizations

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :first_name, presence: true

  before_save { self.email.downcase! }

  class << self
    def from_omniauth(auth)
      info = auth["info"]
      find_or_create_by(email: info["email"]) do |user|
        user.first_name = info["first_name"]
        user.last_name  = info["last_name"]
      end
    end
  end

  def avatar
    authorizations.first.image
  end
end

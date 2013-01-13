class User < ActiveRecord::Base
  has_many :authorizations

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :first_name,
            presence: true

  before_save { self.email.downcase! }

  def avatar
    authorizations.first.image
  end
end

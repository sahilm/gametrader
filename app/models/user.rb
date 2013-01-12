class User < ActiveRecord::Base
  has_many :authorizations

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  before_save { self.email.downcase! }
end

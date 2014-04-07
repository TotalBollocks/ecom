class User < ActiveRecord::Base
  has_secure_password
  
  before_save :downcase_email!
  
  validates :email, presence: true, format: { with: /@/ }, uniqueness: { case_sensitive: false }
  
  private
  
  def downcase_email!
    self.email.downcase!
  end
end

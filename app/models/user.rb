class User < ActiveRecord::Base
    before_create :confirmation_token
    has_many :articles, dependent: :destroy  #delete user will delete all the articles
    #has_many :comments, dependent: :destroy
    before_save { self.email = email.downcase }
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 30 }
    VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
    has_secure_password
    
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
    
    private
    
    def confirmation_token
       if self.confirm_token.blank?
           self.confirm_token=SecureRandom.urlsafe_base64.to_s
       end
    end
    
    def email_activate
        self.email_confirmed = true
        self.confirm_token = nil
        save!(:validate => false)
    end
end
class Article < ActiveRecord::Base
    acts_as_votable
    belongs_to :user
    has_many :comments, dependent: :destroy
    
    validates :title, presence: true, length:{ minimum: 3, maximum: 50 }
    validates :description, presence: true, length:{ minimum: 10, maximum: 2000 }
    validates :user_id, presence: true
    
end
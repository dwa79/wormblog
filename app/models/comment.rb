class Comment < ActiveRecord::Base
    belongs_to :article
    #belongs_to :user
    validates :commenter, presence: true
    validates :body, presence: true, length:{ minimum: 1, maximum: 500 }
    validates :article_id, presence: true
    #validates :user_id, presence: true
end

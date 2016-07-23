class RemovearticleIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :article_id
    remove_column :comments, :user_id
    
  end
end

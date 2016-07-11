class RemoveAttacmentFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :attachment
  end
end

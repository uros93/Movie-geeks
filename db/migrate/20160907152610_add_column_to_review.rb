class AddColumnToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :grade, :integer
  end
end

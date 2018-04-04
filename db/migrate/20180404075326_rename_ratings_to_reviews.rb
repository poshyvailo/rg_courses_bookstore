class RenameRatingsToReviews < ActiveRecord::Migration[5.1]
  def change
    rename_table :ratings, :reviews
  end
end

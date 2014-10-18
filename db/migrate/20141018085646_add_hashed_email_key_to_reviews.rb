class AddHashedEmailKeyToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :encrypted_key, :text
  end
end

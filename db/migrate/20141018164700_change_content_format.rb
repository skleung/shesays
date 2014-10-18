class ChangeContentFormat < ActiveRecord::Migration
  def change
    def up
      change_column :reviews, :content, :text
    end

    def down
      change_column :reviews, :content, :string
    end
  end
end

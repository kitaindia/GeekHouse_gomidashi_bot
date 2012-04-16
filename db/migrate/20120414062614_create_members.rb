class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :user
      t.integer :jyunban_id

      t.timestamps
    end
  end
end

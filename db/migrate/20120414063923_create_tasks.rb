class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :who
      t.string :for
      t.date :when

      t.timestamps
    end
  end
end

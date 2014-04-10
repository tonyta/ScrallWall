class CreateReflections < ActiveRecord::Migration
  def change
    create_table :reflections do |t|
      t.integer :user_id
      t.integer :artifact_id
      t.text :text

      t.timestamps
    end
  end
end

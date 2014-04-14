class CreateReflections < ActiveRecord::Migration
  def change
    create_table :reflections do |t|
      t.integer :artifact_id
      t.string :name
      t.text :text

      t.timestamps
    end
  end
end

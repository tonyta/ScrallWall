class CreateArtifactTags < ActiveRecord::Migration
  def change
    create_table :artifact_tags do |t|
      t.integer :user_id
      t.integer :artifact_id
      t.integer :tag_id

      t.timestamps
    end
  end
end

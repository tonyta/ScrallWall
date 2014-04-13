class AddPictureIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :picture_id, :integer
  end
end

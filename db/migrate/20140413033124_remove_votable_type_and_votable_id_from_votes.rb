class RemoveVotableTypeAndVotableIdFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :votable_id, :integer
    remove_column :votes, :votable_type, :string
  end
end

class AddColumnVotesReportedAndTokenToArtifacts < ActiveRecord::Migration
  def up
    add_column :artifacts, :votes, :integer, default: 0
    add_column :artifacts, :is_reported, :boolean, default: false
    add_column :artifacts, :open311_token, :string
  end
end

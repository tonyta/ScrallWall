class AddPointIndexToArtifacts < ActiveRecord::Migration
  def up
    execute %{
      create index index_on_artifacts_location ON artifacts using gist (
        ST_GeographyFromText(
          'SRID=4326;POINT(' || artifacts.latitude || ' ' || artifacts.longitude || ')'
        )
      )
    }
  end

  def down
    execute %{drop index index_on_artifacts_location}
  end
end

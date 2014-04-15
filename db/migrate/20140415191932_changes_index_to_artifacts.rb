class ChangesIndexToArtifacts < ActiveRecord::Migration
  def up
    execute %{drop index index_on_artifacts_location}
    execute %{
      create index index_on_artifacts_location ON artifacts using gist (
        ST_GeographyFromText(
          'SRID=4326;POINT(' || artifacts.longitude || ' ' || artifacts.latitude || ')'
        )
      )
    }
  end

  def down
    execute %{drop index index_on_artifacts_location}
    execute %{
      create index index_on_artifacts_location ON artifacts using gist (
        ST_GeographyFromText(
          'SRID=4326;POINT(' || artifacts.latitude || ' ' || artifacts.longitude || ')'
        )
      )
    }
  end
end

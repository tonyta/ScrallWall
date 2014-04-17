seeds_path = Pathname.new('/Users/1derfly/Downloads/seeds')
single_path = seeds_path.join('single', '*')
group_path = seeds_path.join('group', '*')


def import_dir(dir_path)
  path = Pathname.new(dir_path)
  artifact = nil
  Dir[path.join('*')].each_with_index do |file, index|
    if index == 0
      artifact = import_new_artifact(file)
    else
      import_existing_artifact(file, artifact)
    end
  end
end

def import_new_artifact(file)
  puts "Seeding #{file}..."
  exif = EXIFR::JPEG.new(file)
  lat = exif.gps.latitude
  lng = exif.gps.longitude
  artifact = Artifact.create(latitude: lat, longitude: lng)

  picture = Picture.create
  picture.image = File.open(file)
  picture.save!

  artifact.pictures << picture
  return artifact
end

def import_existing_artifact(file, artifact)
  puts "Seeding #{file}..."

  picture = Picture.create
  picture.image = File.open(file)
  picture.save!

  artifact.pictures << picture
  return artifact
end

Dir[single_path].each do |file|
  import_new_artifact(file)
end

Dir[group_path].each do |dir_path|
  import_dir(dir_path)
end

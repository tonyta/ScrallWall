
# seeding pics

path = Rails.root.join('db', 'seeds', '*.JPG')
Dir[path].each do |file|
  puts "Seeding #{file}..."
  exif = EXIFR::JPEG.new(file)
  lat = exif.gps.latitude
  lng = exif.gps.longitude
  artifact = Artifact.create(latitude: lat, longitude: lng)

  picture = Picture.create
  picture.image = File.open(file)
  picture.save!

  artifact.pictures << picture
end

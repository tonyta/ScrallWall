class AddPictureToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :picture, :string
  end
end



p = Picture.create(~~~)

p.picture = File.open('greg.gif')

p.save!

p.picture.url #=> 'uploads/picture/12343-3434-2134-45373434.gif'

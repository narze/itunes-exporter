class ItunesTrack < Struct.new(*%i{
  track_id
  size
  total_time
  disc_number
  disc_count
  track_number
  track_count
  year
  date_modified
  date_added
  bit_rate
  sample_rate
  compilation
  artwork_count
  persistent_id
  track_type
  file_folder_count
  library_folder_count
  name
  artist
  album
  genre
  kind
  location
})

  def initialize(attributes)
    attributes.each { |k, v| self[k] = v }
  end
end

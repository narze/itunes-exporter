require 'mp3info'

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
  play_count
  play_date
  play_date_utc
  skip_count
  skip_date
  loved
  hated
  rating
  album_rating
  album_rating_computed
  comments
})

  def initialize(attributes)
    attributes.each { |k, v| self[k] = v }
  end

  def location_absolute
    location.sub(%r{^file://(localhost)?}, '')
  end

  def rating_ratio
    (rating || 0) / 100.0
  end

  # TODO: Add test
  def write_rating_and_play_count
    Mp3Info.open(location_absolute) do |mp3|
      mp3.tag2.TXXX = [
        "FMPS_Rating\u0000#{rating_ratio}",
        "FMPS_PlayCount\u0000#{play_count}",
      ]
    end
  end
end

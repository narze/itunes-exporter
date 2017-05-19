require 'mp3info'
require 'sqlite3'

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

  def ItunesTrack.db
    @db ||= SQLite3::Database.new("/Users/#{Etc.getlogin}/Library/Application Support/Clementine/clementine.db")
  end

  def initialize(attributes)
    attributes.each { |k, v| self[k] = v }
  end

  def location_absolute
    URI.decode(location.sub(%r{^file://(localhost)?}, ''))
  end

  def rating_ratio
    (rating || 0) / 100.0
  end

  def play_count_or_zero
    play_count || 0
  end

  def last_played
    play_date_utc ? play_date_utc.to_time.to_i : -1
  end

  # NOTE: Clementine does not load these tags to db, but writes these from app
  def write_rating_and_play_count
    Mp3Info.open(location_absolute) do |mp3|
      mp3.tag2.TXXX = [
        "FMPS_Rating\u0000#{rating_ratio}",
        "FMPS_PlayCount\u0000#{play_count || 0}",
      ]
    end
  end

  def write_clementine
    db = ItunesTrack.db

    result = db.execute(
      "SELECT rating, playcount FROM songs WHERE title = ? and album = ? and artist = ?",
      [name, album, artist]
    )

    if result.size < 1
      puts "Not found #{self.name}. Skipping..."
      return false
    end

    db.execute(
      "UPDATE songs SET rating = ?, playcount = ?, lastplayed = ? WHERE title = ? and album = ? and artist = ?",
      [rating_ratio, play_count_or_zero, last_played, name, album, artist]
    )

    puts "SET rating = #{self.rating_ratio}, playcount = #{play_count_or_zero} for #{self.name}"
    return true
  end
end

require 'plist'

class ItunesPlaylist < Struct.new(:tracks, :playlists)
  def initialize(path)
    plist = Plist.parse_xml(path)

    self.tracks = plist['Tracks'].values.map do |track_data|
      ItunesTrack.new track_id: track_data['Track ID'],
                      size: track_data['Size'],
                      total_time: track_data['Total Time'],
                      disc_number: track_data['Disc Number'],
                      disc_count: track_data['Disc Count'],
                      track_number: track_data['Track Number'],
                      track_count: track_data['Track Count'],
                      year: track_data['Year'],
                      date_modified: track_data['Date Modified'],
                      date_added: track_data['Date Added'],
                      bit_rate: track_data['Bit Rate'],
                      sample_rate: track_data['Sample Rate'],
                      compilation: track_data['Compilation'],
                      artwork_count: track_data['Artwork Count'],
                      persistent_id: track_data['Persistent ID'],
                      track_type: track_data['Track Type'],
                      file_folder_count: track_data['File Folder Count'],
                      library_folder_count: track_data['Library Folder Count'],
                      name: track_data['Name'],
                      artist: track_data['Artist'],
                      album: track_data['Album'],
                      genre: track_data['Genre'],
                      kind: track_data['Kind'],
                      location: track_data['Location'],
                      play_count: track_data['Play Count'],
                      play_date: track_data['Play Date'],
                      play_date_utc: track_data['Play Date UTC'],
                      loved: track_data['Loved'],
                      hated: track_data['Hated'],
                      skip_count: track_data['Skip Count'],
                      skip_date: track_data['Skip Date'],
                      rating: track_data['Rating'],
                      album_rating: track_data['Album Rating'],
                      album_rating_computed: track_data['Album Rating Computed'],
                      comments: track_data['Comments']
    end
  end
end

require "itunes_exporter/version"
require "itunes_exporter/itunes_playlist"
require "itunes_exporter/itunes_track"

module ItunesExporter
  class << self
    def load(path)
      ItunesPlaylist.new(path)
    end
  end
end

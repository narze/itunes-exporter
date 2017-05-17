require "itunes_exporter/version"
require "itunes_exporter/itunes_playlist"

module ItunesExporter
  class << self
    def load(path)
      ItunesPlaylist.new
    end
  end
end

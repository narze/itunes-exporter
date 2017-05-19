require "spec_helper"

RSpec.describe ItunesPlaylist do
  subject(:itunes_playlist) { ItunesPlaylist.new(xml_path) }
  let(:xml_path) { File.join(File.expand_path('../support', __FILE__), 'iTunes Library.xml') }

  it 'initialize ItunesPlaylist instance' do
    is_expected.to be_an ItunesPlaylist
  end

  describe '#tracks' do
    subject(:tracks) { itunes_playlist.tracks }

    it { is_expected.to be_an Array }

    it { expect(subject.size).to eq 3 }

    it { expect(subject).to all be_an ItunesTrack }

    describe 'first track' do
      subject { tracks.first }

      it 'has matching attributes' do
        is_expected
          .to have_attributes track_id: 74,
                              size: 9771859,
                              total_time: 233377,
                              disc_number: 2,
                              disc_count: 2,
                              track_number: 14,
                              track_count: 20,
                              year: 2009,
                              date_modified: DateTime.parse('2013-03-09T08:25:32Z'),
                              date_added: DateTime.parse('2017-05-17T13:06:35Z'),
                              bit_rate: 320,
                              sample_rate: 44100,
                              play_count: 1,
                              play_date: 3577904253,
                              play_date_utc: DateTime.parse('2017-05-17T15:17:33Z'),
                              loved: true,
                              compilation: true,
                              artwork_count: 1,
                              persistent_id: '0E272F11ED9075C4',
                              track_type: 'File',
                              file_folder_count: 5,
                              library_folder_count: 1,
                              name: 'masterpiece',
                              artist: 'Hommarju feat.Latte',
                              album: 'EXIT TRANCE PRESENTS SPEED アニメトランス BEST 7',
                              genre: 'J-Trance',
                              kind: 'MPEG audio file',
                              location: 'file:///Users/username/Music/iTunes%20test/iTunes%20Media/Music/Compilations/EXIT%20TRANCE%20PRESENTS%20SPEED%20%E3%82%A2%E3%83%8B%E3%83%A1%E3%83%88%E3%83%A9%E3%83%B3%E3%82%B9%20BEST%207/2-14%20masterpiece.mp3',
                              location_absolute: '/Users/username/Music/iTunes%20test/iTunes%20Media/Music/Compilations/EXIT%20TRANCE%20PRESENTS%20SPEED%20%E3%82%A2%E3%83%8B%E3%83%A1%E3%83%88%E3%83%A9%E3%83%B3%E3%82%B9%20BEST%207/2-14%20masterpiece.mp3',
                              skip_count: 1,
                              skip_date: DateTime.parse('2012-05-19T21:28:40Z'),
                              rating: 100,
                              rating_ratio: 1.0,
                              album_rating: 60,
                              album_rating_computed: true,
                              comments: 'Hello World'
      end
    end
  end
end

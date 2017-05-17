require "spec_helper"

RSpec.describe ItunesExporter do
  it "has a version number" do
    expect(ItunesExporter::VERSION).not_to be nil
  end

  describe '.load' do
    subject { ItunesExporter.load(xml_path) }

    let(:xml_path) { File.join(File.expand_path('../support', __FILE__), 'iTunes Library.xml') }

    it 'initialize ItunesPlaylist instance' do
      is_expected.to be_an ItunesPlaylist
    end
  end
end

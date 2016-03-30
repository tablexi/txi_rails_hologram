require_relative "../../spec_helper"
require "txi_rails_hologram/builder"

describe TxiRailsHologram::Builder do

  subject { described_class.new }

  describe "#build" do
    context "with valid params" do
      let(:destination) { Dir.mktmpdir }
      before do
        config = {
          "source" => [Rails.root.join("app/assets/stylesheets")],
          "destination" => destination,
        }
        subject.build(config)
      end

      it "creates a styleguide" do
        expect(File.exist?(File.join(destination, "basics.html"))).to be_truthy
      end

      it "puts in the default head" do
        expect(File.read(File.join(destination, "basics.html"))).to match(/application.*\.css/)
      end

      it "puts in a custom foot" do
        expect(File.read(File.join(destination, "basics.html"))).to match(/custom/i)
      end
    end

  end
end

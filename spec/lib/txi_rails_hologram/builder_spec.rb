require_relative "../../spec_helper"
require "txi_rails_hologram/builder"

describe TxiRailsHologram::Builder do

  subject { described_class.new }

  describe "#build" do
    context "with valid params" do
      let(:destination) { Dir.mktmpdir }

      it "creates a styleguide" do
        config = {
          "source" => [Rails.root.join("app/assets/stylesheets")],
          "destination" => destination,
        }
        subject.build(config)

        expect(File.exist?(File.join(destination, "basics.html"))).to be_truthy
      end
    end

  end
end

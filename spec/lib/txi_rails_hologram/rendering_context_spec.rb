require_relative "../../spec_helper"
require "txi_rails_hologram/rendering_context"

describe TxiRailsHologram::RenderingContext do

  subject { described_class.instance }

  it "handles named routes" do
    expect(subject.root_path).to eq("/")
  end

  it "handles helper methods defined in application" do
    expect(subject.strong_text("Fierce")).to eq("<strong>Fierce</strong>")
  end

  it "handles stock Rails helper methods" do
    expect(subject.link_to("Example", "http://example.com"))
      .to include(%(a href="http://example.com))
  end

  it "handles rendering partials" do
    expect(subject.render("shared/logo"))
      .to include(%(img src="/images/logo.svg))
  end

  it "handles helpers from other gems" do
    expect(subject.hcard(fn: "First Last")).to include(%(vcard))
  end

end

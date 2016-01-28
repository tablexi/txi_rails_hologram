require_relative "../../spec_helper"
require "txi_rails_hologram/rendering_context"
require "txi_rails_hologram/template_variables_ext"

describe "TemplateVariables Extension" do

  let(:rendering_context) { spy }

  subject { Hologram::TemplateVariables.new({}) }

  before do
    allow(TxiRailsHologram::RenderingContext).to receive(:instance)
      .and_return(rendering_context)
  end

  it "delegates stylesheet_link_tag to the context" do
    subject.stylesheet_link_tag("one")
    expect(rendering_context).to have_received(:stylesheet_link_tag).with("one")
  end

  it "delegates stylesheet_link_tag to the context" do
    subject.javascript_include_tag("two")
    expect(rendering_context).to have_received(:javascript_include_tag).with("two")
  end

  it "delegates stylesheet_link_tag to the context" do
    subject.asset_path("three")
    expect(rendering_context).to have_received(:asset_path).with("three")
  end

end

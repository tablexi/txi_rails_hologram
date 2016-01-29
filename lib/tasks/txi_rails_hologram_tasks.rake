require "txi_rails_hologram/builder"

desc "Explaining what the task does"
namespace :txi_rails_hologram do
  task build: :environment do
    config = YAML.load_file(Rails.root.join("hologram_config.yml"))
    TxiRailsHologram::Builder.new.build(config)
  end
end

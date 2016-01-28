require "txi_rails_hologram/builder"

desc "Explaining what the task does"
namespace :txi_rails_hologram do
  task build: :environment do
    TxiRailsHologram::Builder.new.build
  end
end

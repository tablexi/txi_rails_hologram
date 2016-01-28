Rails.application.routes.draw do
  mount TxiRailsHologram::Engine => "/txi_rails_hologram"

  root to: "examples#index"
end

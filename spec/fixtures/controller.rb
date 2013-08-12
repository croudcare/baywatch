class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
  def render(*attributes); end
end

require_relative './controllers/baywatch'
require_relative './controllers/beaches'
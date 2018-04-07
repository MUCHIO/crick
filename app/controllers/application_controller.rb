class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require 'open-uri'
  require 'rest-client'

  def hello

  end
end

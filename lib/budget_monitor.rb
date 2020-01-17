require 'sinatra'
require "sinatra/reloader" if development?

class BudgetMonitor < Sinatra::Application
  configure :development do
    register Sinatra::Reloader
  end

  before do
    if !params[:flash].nil?
      @flash = params[:flash]
    end
    if !params[:flash_error].nil?
      @flash_error = params[:flash_error]
    end
  end

  run! if app_file == $0
end
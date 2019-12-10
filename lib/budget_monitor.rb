require 'sinatra'

class BudgetMonitor < Sinatra::Application

  error do |err|
    puts "Error here!"
    raise "Error: #{err}"
  end

  get '/' do
    'Hello world'
  end

  run! if app_file == $0
end
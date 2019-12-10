require 'sinatra'

class BudgetMonitor < Sinatra::Application
  configure { set :show_exceptions, false }

  error JSON::ParserError do |e|
    halt 400, 'Parse error'
  end

  error do |e|
    halt 500, "Something went wrong: #{e.inspect}"
  end
end

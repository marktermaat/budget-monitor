require 'sinatra'

class BudgetMonitor < Sinatra::Application
  configure { set :show_exceptions, false }

  error JSON::ParserError do |e|
    halt 400, 'Parse error'
  end

  error Sequel::ValidationFailed do |e|
    halt 400, e.message
  end

  error do |e|
    puts e.inspect
    puts e.backtrace.join("\n")
    halt 500, "Something went wrong: #{e.inspect}"
  end
end

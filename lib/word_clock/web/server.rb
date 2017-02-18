# frozen_string_literal: true
require 'sinatra'

set server: 'thin'
set connections: []
set events: []

get '/' do
  erb :events, layout: true, locals: {
    title: 'WordClock - letzte Ereignisse',
    events: settings.events.reverse,
    sse_events_url: '/stream'
  }
end

get '/stream', provides: 'text/event-stream' do
  warn "New client connecting to stream: #{request.ip} - #{request.user_agent}"
  headers 'Access-Control-Allow-Origin' => '*'

  stream :keep_open do |out|
    settings.connections << out
    out.callback { settings.connections.delete(out) }
  end
end

post '/events' do
  msg = params[:msg]

  warn "New event from: #{request.ip}: #{msg}"
  settings.events << JSON.parse(msg)

  settings.connections.each do |out|
    out << "data: #{msg}\n\n" unless out.closed?
  end

  204 # response without entity body
end

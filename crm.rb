# require_relative 'contact'
require 'sinatra'

get '/' do
  @crm_app_name = "Tobi's CRM"
  erb :index
end

get '/contacts.new' do
  erb :new
end




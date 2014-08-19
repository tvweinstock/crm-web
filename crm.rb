require_relative 'contact'
require 'sinatra'

get '/' do
  @crm_app_name = "Tobi's CRM"
  erb :index
end

get '/contacts/new' do
  erb :new
end

get "/contacts" do
  @contacts = []
  @contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor") 
  @contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")
  @contacts << Contact.new("Chris", "Johnston", "chris@bitmakerlabs.com", "Instructor")
  erb :contacts
end




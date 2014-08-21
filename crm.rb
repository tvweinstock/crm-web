require 'sinatra'
require 'data_mapper'
require_relative 'contact'
require_relative 'rolodex'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

@@rolodex = Rolodex.new

get '/' do
  @crm_app_name = "Tobi's CRM"
  erb :index
end


get "/contacts" do
  erb :contacts
end

get "/contacts/new" do
  erb :new_contact
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  @@rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

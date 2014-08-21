require 'sinatra'
require 'data_mapper'
require_relative 'rolodex'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  attr_accessor :id, :first_name, :last_name, :email, :note

  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end
end


@@rolodex = Rolodex.new
@@rolodex.add_contact(Contact.new('Johnny', 'Bravo', 'johnny@gmail.com', 'Rockstar'))

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

get "/contacts/1000" do
  @contact = @@rolodex.find(1000)
  erb :show_contact
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  contact = @@rolodex.find(1000)
  redirect to('/contacts')
end

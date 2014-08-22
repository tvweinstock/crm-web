require 'sinatra'
require 'data_mapper'
require_relative 'rolodex'

DataMapper.setup(:default, "sqlite3:database.sqlite3") #file to store our database 

class Contact
  include DataMapper::Resource # module that allows us to interface with the DataMapper database

  # attr_accessor :id, :first_name, :last_name, :email, :note, :active
  # attr_reader :created_date

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
  property :active, Boolean
  property :created_date, Date

  # def initialize(first_name, last_name, email, note, active, created_date)
  #   @first_name = first_name
  #   @last_name = last_name
  #   @email = email
  #   @note = note
  #   @active = true
  #   @created_date = Time.now

end

DataMapper.finalize
DataMapper.auto_upgrade!


@@rolodex = Rolodex.new

get '/' do
  @crm_app_name = "Tobi's CRM"
  erb :index
end


get "/contacts" do
  erb :contacts
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note], params[:active]) #params[:created_date])
  @@rolodex.add_contact(new_contact)
  redirect to('/contacts')
end


get "/contacts/new" do
  erb :new_contact
end

get "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]
    @contact.active = params[:active]

    redirect to ("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @@rolodex.remove_contact(@contact)
    redirect to ("/contacts")
  else
    raise Sinatra::NotFound
  end

end



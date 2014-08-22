require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3") #file to store our database 

class Contact
  include DataMapper::Resource # module that allows us to interface with the DataMapper database

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
  property :status, Boolean
  property :created_date, Date

  #   @created_date = Time.now

end

DataMapper.finalize
DataMapper.auto_upgrade!


get '/' do
  @crm_app_name = "Tobi's CRM"
  erb :index
end


get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

post "/contacts" do
  contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note],
    :status => params[:status],
    :created_date => Date.today
    )
  redirect to('/contacts')
end


get "/contacts/new" do
  erb :new_contact
end


get "/contacts/find" do
  erb :search_contact
end

get "/contacts/search" do
  @contacts = Contact.all(first_name: params[:first_name])
  erb :contacts
end

get "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]
    @contact.status = params[:status]

    @contact.save

    redirect to ("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
    redirect to ("/contacts")
  else
    raise Sinatra::NotFound
  end

end


get '/' do
  @links = Link.all
  erb :index
end

post '/links' do
  url = params["url"]
  title = params["title"]
  tags = params["tags"].split(" ").map{|tag| Tag.new(:text => tag)}
  Link.create(:url => url, :title => title, :tags => tags)  
  redirect to('/')
end
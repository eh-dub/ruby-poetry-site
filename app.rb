require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite://development.db'

class Post < ActiveRecord::Base
	validates_uniqueness_of :title
	validates_presence_of :title
end

class Rhyme_Key < ActiveRecord::Base
	validates_uniqueness_of :rhyme_key
end

def generate_limerick
	max = Post.count

end

get '/' do 
	
end

post '/' do

end

get '/p' do
	@posts = [].push Post.find(1)
	haml :posts
end

get '/limerick' do
	haml :limerick
end

post '/limerick' do 

end

__END__

@@ layout
%html
	= yield

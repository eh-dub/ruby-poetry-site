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
	'hi'
end

post '/' do

end

get '/p' do
	@posts = [].push Post.find(1)
	haml :posts
end

get '/limericks' do
	@max = Rhyme_Key.count
	# x = Rhyme_Key.count
	# a_key_id = 1 + Random.rand(x)
	# b_key_id = a_key_id

	# while (a_key_id == b_key_id) do 
	# 	b = 1 + Random.rand(x)
	# end

	# @a_key = Rhyme_Key.find(a_key_id)
	# # b_key = Rhyme_Key.find(b_key_id)
	# # a_posts = Post.where(rhyme_key => a_key).shuffle
	# # b_posts = Post.where(rhyme_key => b_key).shuffle
	# # @a1 = a_posts.at(0)
	# # @b1 = b_posts.at(0)


	haml :limerick
end

post '/limerick' do 

end

__END__

@@ layout
%html
	= yield

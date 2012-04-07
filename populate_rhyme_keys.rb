require 'sinatra'
require 'sinatra/activerecord'

class Post < ActiveRecord::Base
	validates_uniqueness_of :title
	validates_presence_of :title
end

# #in future posts should have a has many relationship with rhyme keys
class Rhyme_Key < ActiveRecord::Base
	validates_uniqueness_of :rhyme_key
end

posts = Post.all
posts.each do |post|
	rk = Rhyme_Key.new ({:rhyme_key => post.rhyme_key})
	rk.save
end
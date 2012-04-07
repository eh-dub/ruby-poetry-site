require 'sinatra'
require 'sinatra/activerecord'

class Post < ActiveRecord::Base
  validates_uniqueness_of :title
  validates_presence_of :title
end

class Rhyme_Key < ActiveRecord::Base
	validates_uniqueness_of :rhyme_key
end

Rhyme_Key.all.each do |key|
	key.delete
end


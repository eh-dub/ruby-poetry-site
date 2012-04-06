#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/activerecord'
require 'open-uri'
require 'ruby_rhymes'
require 'json'


class RedditPost

  attr_reader :title
  attr_reader :author
  attr_reader :permalink
  attr_reader :subreddit
  attr_reader :created_utc
  attr_reader :upvotes
  attr_reader :downvotes
  attr_reader :rhyme_keys

  def initialize (post_data) 
    @title = post_data.fetch('title')
    @author = post_data.fetch('author')
    @permalink = "www.reddit.com" + post_data.fetch('permalink')
    @subreddit = post_data.fetch('subreddit')
    @created_utc = post_data.fetch('created_utc')
    @upvotes = post_data.fetch('ups')
    @downvotes = post_data.fetch('downs')
    rhyme_keys = @title.to_phrase.rhyme_keys
    @rhyme_keys = (rhyme_keys == nil) ? "nil" : rhyme_keys.to_s.slice(1, rhyme_keys.to_s.length-2)
  end

  def to_hash
    { "title"=>@title, "author"=>@author, "permalink"=>@permalink, 
      "subreddit"=>@subreddit, "created_utc"=>@created_utc, "upvotes"=>@upvotes,
      "downvotes"=>@downvotes
    }
  end


end

class Post < ActiveRecord::Base
  validates_uniqueness_of :title
  validates_presence_of :title
end

class RedditPage

  def initialize (page_data)
    @next_page_id = page_data.fetch('after')
    @after_id = "?after=" + @next_page_id
    @prev_page_id = page_data.fetch('before')
    posts_data = page_data.fetch('children')
    @posts = []
    posts_data.each { |post| @posts.push RedditPost.new(post.fetch('data'))}

  end
  attr_reader :after_id
  attr_reader :posts

end


def scrape_page (url)
  json = open(url)
  page_data = JSON.load(json).fetch('data')
  rpage = RedditPage.new(page_data)
  rpage.posts.each do |post|
    yield post
  end
  rpage.after_id

end

#Scrapes reddit and returns an array of post objects

posts = []
url = "http://www.reddit.com/r/all.json"
after_id = scrape_page(url) {|post_title| posts.push(post_title)}
i = 0

#Collects first 50 pages of /r/all
while (i < 50) do

  page = url + after_id
  after_id = scrape_page(page) {|post| posts.push(post)}
  i += 1

end

posts.each do |post|
  p = Post.create({:title => post.title, :author => post.author, :permalink => post.permalink, :subreddit => post.subreddit, :created_utc => post.created_utc, :upvotes => post.upvotes, :downvotes => post.downvotes, :rhyme_keys => post.rhyme_keys})
  #p.save
end





  






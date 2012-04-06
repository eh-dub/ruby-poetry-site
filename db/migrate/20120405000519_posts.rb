class Posts < ActiveRecord::Migration
  def self.up
  	create_table :posts do |t|
  		t.string :title
  		t.string :author
  		t.string :permalink
  		t.string :subreddit
  		t.string :created_utc
  		t.integer :upvotes
  		t.integer :downvotes
  		t.string :rhyme_keys
  	end	
  	add_index :posts, :title
  end

  def self.down
  	drop_table :posts
  end
end

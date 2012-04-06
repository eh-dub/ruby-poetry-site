class Limericks < ActiveRecord::Migration
  def self.up
  	create_table :limericks do |t|
  		t.integer :line_1_post_id
  		t.integer :line_2_post_id
  		t.integer :line_3_post_id
  		t.integer :line_4_post_id
  		t.integer :line_5_post_id
  		t.integer :upvotes
  		t.integer :downvotes
  		t.string :title
  		t.integer :title_upvotes
  		t.integer :title_downvotes
  	end
  	add_index :limericks, :id
  end

  def self.down
  	drop_table :limericks
  end
end

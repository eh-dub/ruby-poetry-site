class RhymeKeys < ActiveRecord::Migration
  def self.up
		create_table :rhyme_keys do |t|
			t.string :rhyme_key
		end
		add_index :rhyme_keys, :rhyme_key
  end

  def self.down
	drop_table :rhyme_keys
  end
end

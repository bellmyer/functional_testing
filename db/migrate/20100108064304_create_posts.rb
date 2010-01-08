class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
    
    add_index :posts, :name
  end

  def self.down
    drop_table :posts
  end
end

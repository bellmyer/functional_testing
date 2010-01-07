class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :name
      t.text :value

      t.timestamps
    end
    
    add_index :settings, :name, :unique => true
  end

  def self.down
    drop_table :settings
  end
end

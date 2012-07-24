class CreatePages < ActiveRecord::Migration
  
  def self.up
    create_table :pages do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.datetime :published_on, :null => true, :default => nil

      t.timestamps
    end
    add_index :pages, :title, :unique => true
  end

  def self.down
    drop_table :pages
    remove_index :pages, :title, :unique => true
  end
  
end

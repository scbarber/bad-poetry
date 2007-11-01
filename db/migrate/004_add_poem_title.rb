class AddPoemTitle < ActiveRecord::Migration
  def self.up
    add_column "poems", "title", :string
  end

  def self.down
    remove_column "poems", "title"
  end
end

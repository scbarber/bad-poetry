class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column 'username', :string
      t.column 'password', :string
      t.column 'profile', :text
    end
    add_column :poems, 'user_id', :integer
  end

  def self.down
    drop_table :users
  end
end

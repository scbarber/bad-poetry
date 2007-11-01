class CreatePoems < ActiveRecord::Migration
  def self.up
    create_table :poems do |t|
      t.column "content", :text
      t.column "author", :string
      t.column "created_at", :datetime
    end
  end

  def self.down
    drop_table :poems
  end
end

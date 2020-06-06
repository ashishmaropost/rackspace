class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name
      t.string :website_url
      t.string :shortening
      t.text :website_headings
      t.text :description
      t.timestamps
    end
  end
end

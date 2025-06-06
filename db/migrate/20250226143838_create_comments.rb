class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :startup, null: false, foreign_key: true
      t.text :context

      t.timestamps
    end
  end
end

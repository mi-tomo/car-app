class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string      :session_id
      t.string      :maker
      t.string      :name
      t.string      :model
      t.string        :exhaust
      t.string        :modelyear
      t.string        :color
      t.float        :distance
      t.string        :price
      t.string      :repare
      t.string      :evaluation
      t.string      :unit

      t.timestamps null: true

     
    end
  end
end

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string      :name
      t.string      :session_id
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

class CreateCarnames < ActiveRecord::Migration[5.2]
  def change
    create_table :carnames do |t|
      t.string      :maker_name
      t.string      :maker
      t.string      :name
      t.string      :address
    end
  end
end

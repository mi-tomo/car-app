class CreateCarnames < ActiveRecord::Migration[5.2]
  def change
    create_table :carnames do |t|
      t.string      :maker_name, unique: true
      t.string      :maker, unique: true
      t.string      :name, unique: true
      t.string      :address
      # validates :name, uniqueness: true
      
    end
  end
end

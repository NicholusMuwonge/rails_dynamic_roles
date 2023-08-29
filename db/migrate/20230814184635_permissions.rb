class Permissions < ActiveRecord::Migration[7.0]
  def change
    create_table(:permissions)  do |t|
      t.string :name
      t.string :controller
      t.text :description
      t.string :controller_method

      t.timestamps
    end
  end
end

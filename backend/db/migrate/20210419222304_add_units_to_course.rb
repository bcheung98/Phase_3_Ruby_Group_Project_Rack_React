class AddUnitsToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :units, :integer
  end
end

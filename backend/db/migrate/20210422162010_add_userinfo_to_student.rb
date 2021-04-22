class AddUserinfoToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :username, :string
    add_column :students, :email, :string
    add_column :students, :password, :string
  end
end

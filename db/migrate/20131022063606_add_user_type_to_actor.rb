class AddUserTypeToActor < ActiveRecord::Migration
  def change
    add_column :actors, :user_type, :string
  end
end

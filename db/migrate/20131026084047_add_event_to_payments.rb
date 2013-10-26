class AddEventToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :event_id, :integer
    add_column :payments, :user_id, :integer
  end
end

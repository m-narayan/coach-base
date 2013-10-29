class RemovePriceFromEvent < ActiveRecord::Migration
  def up
    remove_column :events, :price
  end

  def down
    add_column :events, :price, :decimal
  end
end

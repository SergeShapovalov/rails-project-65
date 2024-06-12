class AddStateToBulletin < ActiveRecord::Migration[7.1]
  def change
    add_column :bulletins, :state, :string, null:false, default: 'draft'
  end
end

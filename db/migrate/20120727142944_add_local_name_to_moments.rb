class AddLocalNameToMoments < ActiveRecord::Migration
  def change
    add_column :moments, :credit_local_name, :string
  end
end

class AddSortDataToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sort_by, :string

    add_column :pages, :sort_order, :string

  end
end

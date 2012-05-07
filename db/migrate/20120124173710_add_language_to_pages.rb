class AddLanguageToPages < ActiveRecord::Migration
  def change
    add_column :pages, :language_id, :integer
  end
end

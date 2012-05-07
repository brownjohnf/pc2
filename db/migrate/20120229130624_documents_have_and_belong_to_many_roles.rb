class DocumentsHaveAndBelongToManyRoles < ActiveRecord::Migration
  def self.up
    create_table :documents_roles, :id => false do |t|
      t.references :document, :role
    end
  end
 
  def self.down
    drop_table :documents_roles
  end
end 

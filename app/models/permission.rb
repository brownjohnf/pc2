class Permission < ActiveRecord::Base

  belongs_to :privilege
  belongs_to :permissable, :polymorphic => true

  validates :permissable_type, :permissable_id, :privilege_id, :group_id, :presence => true
  
  default_scope :order => 'group_id ASC'

  def target_title
    scope.name.constantize.find_by_id(target_id).title
  end

end

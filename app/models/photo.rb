class Photo < ActiveRecord::Base

  has_attached_file :photo, :styles => { :icon => '100x100#', :thumb => '150x150', :small => '255x255', :medium => '350x350', :large => '980x980' }

  belongs_to :user

  has_many :pages

  after_destroy :reset_pointers

  private

  def reset_pointers
    
  end

end

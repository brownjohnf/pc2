class Language < ActiveRecord::Base

  validates :name, :code, :presence => true

  has_many :pages
  has_many :case_studies

end

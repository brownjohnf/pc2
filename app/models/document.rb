class Document < ActiveRecord::Base

  has_attached_file :file
  validates_attachment_presence :file
  acts_as_taggable_on :tags

  belongs_to :user
  belongs_to :attachable, :polymorphic => true

  validates :name, :presence => true

  before_validation :clear_empty_attrs

  private

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
      self.name = self.file_file_name if name.nil?
    end

end

class Document < ActiveRecord::Base

  has_attached_file :file,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  validates_attachment_presence :file
  acts_as_taggable_on :tags

  belongs_to :user
  belongs_to :language
  belongs_to :attachable, :polymorphic => true
  
  has_many :stacks, :as => :stackable, :dependent => :destroy
  
  has_and_belongs_to_many :roles

  accepts_nested_attributes_for :stacks
  
  validates :name, :presence => true

  before_validation :clear_empty_attrs

  def canonical_title
    self.name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  private

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
      self.name = self.file_file_name if name.nil?
    end

end

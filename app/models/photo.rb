class Photo < ActiveRecord::Base

  has_attached_file :photo,
    :styles => { :icon => '100x100#', :thumb => '150x150', :small => '255x255', :medium => '350x350', :large => '980x980>' },
    :storage => :s3,
    :bucket => 'pcsenegal-dev-com',
    :s3_credentials => {
      :access_key_id => ENV['AKIAJU3H242YEKJKQM2Q'],
      :secret_access_key => ENV['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']
    }
  validates_attachment_presence :photo

  acts_as_taggable_on :tags

  belongs_to :imageable, :polymorphic => true
  belongs_to :user

  has_many :pages
  has_many :case_studies
  has_many :moments
  has_many :users
  has_many :stacks, :as => :stackable, :dependent => :destroy

  accepts_nested_attributes_for :stacks

  before_validation :clear_empty_attrs
  validates :title, :imageable_id, :imageable_type, :user_id, :presence => true

  after_destroy :reset_pointers

  default_scope :order => 'photos.created_at DESC'

  private

    def reset_pointers
      User.where(:photo_id => self).each do |u|
        u.photo_id = nil
        u.save
      end

      Page.where(:photo_id => self).each do |u|
        u.photo_id = nil
        u.save
      end

      Moment.where(:photo_id => self).each do |u|
        u.photo_id = nil
        u.save
      end
    end

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
      self.title = self.photo_file_name if title.nil?
    end

end

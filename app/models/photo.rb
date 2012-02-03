class Photo < ActiveRecord::Base

  #
  # small is for span-4
  # medium is for span-8
  has_attached_file :photo, :styles => { :icon => '80x80#', :thumb => '100x100', :small => '200x200', :medium => '380x380', :large => '980x980>', :full => '1140x1140' }
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

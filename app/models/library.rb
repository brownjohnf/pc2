class Library < ActiveRecord::Base
  
  require 'zip/zip'
  require 'zip/zipfilesystem'

  acts_as_taggable_on :tags
  
  # records of stackable objects linked against this library
  has_many :stacks, :dependent => :destroy

  # legacy
  # has_many :documents, :through => :stacks, :class_name => 'Document'
  # has_many :photos, :through => :stacks, :class_name => 'Photo'

  # user who owns/manages this library
  belongs_to :user

  validates :name, :user_id, :country, :presence => true

  # retrieves the actual document objects from the stacks
  def documents
    documents = []
    stacks.where(:stackable_type => 'Document').all.each do |stack|
      documents << stack.stackable
    end
    documents
  end

  # retrieves the actual photo objects from the stacks
  def photos
    photos = []
    stacks.where(:stackable_type => 'Photo').all.each do |stack|
      photos << stack.stackable
    end
    photos
  end

  # sets the url to include the title
  def to_param
    "#{id}-#{canonical_title.parameterize}"
  end

  # standard title attribute, for standardization
  def canonical_title
    name
  end
  
  # all objects in the library
  def contents
    documents + photos
  end
  
  # file name for downloading compressed library, including extension
  def file_name
    "#{self.full_name}.zip"
  end
  
  # full name of the archive, for use as folder name
  def full_name
    "#{self.name}-all_files"
  end
  
  # package library into .zip file for bulk download
  def bundle
    bundle_filename = "public/system/#{file_name}"

    # check to see if the file exists already, and if it does, delete it.
    if File.file?(bundle_filename)
      File.delete(bundle_filename)
    end

    # set the bundle_filename attribute of this object
    #self.bundle_filename = "/uploads/#{name}-all_files.zip"

    # open or create the zip file
    Zip::ZipFile.open(bundle_filename, Zip::ZipFile::CREATE) {
      |zipfile|
      # collect the album's tracks
      self.documents.collect {
        |document|
          # add each track to the archive, names using the track's attributes
          zipfile.add( "#{full_name}/files/#{document.name}", document.file.to_file)
      }
      self.photos.collect {
        |photo|
          # add each track to the archive, names using the track's attributes
          zipfile.add( "#{full_name}/photos/#{photo.title}-#{photo.attribution ? photo.attribution : photo.user.name}", photo.photo.to_file)
      }
    }

    # set read permissions on the file
    File.chmod(0644, bundle_filename)

    # save the object
    self.save
  end

end

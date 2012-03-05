class Library < ActiveRecord::Base
  
  require 'zip/zip'
  require 'zip/zipfilesystem'

  acts_as_taggable_on :tags

  has_many :stacks, :dependent => :destroy
  has_many :documents, :through => :stacks
  has_many :photos, :through => :stacks

  belongs_to :user

  validates :name, :user, :country, :presence => true

  def to_param
    "#{id}-#{name.parameterize}"
  end
  
  def contents
    self.documents + self.photos
  end
  
  def file_name
    "#{self.full_name}.zip"
  end
  
  def full_name
    "#{self.name}-all_files"
  end
  
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

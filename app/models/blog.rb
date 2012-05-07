# @author John Brown
# This model holds blog addresses, primarily for users but not exclusively.
#
# @todo Should be merged with website, and an option added to website specifying whether or not it's a blog.
#
class Blog < ActiveRecord::Base

  acts_as_taggable_on :tags

  belongs_to :user
  
  validates :url, :presence => true

end

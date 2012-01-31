class CaseStudy < ActiveRecord::Base

  acts_as_taggable_on :tags

  validates :title, :language, :summary, :presence => true

  belongs_to :language
  belongs_to :photo

  before_save :clear_empty_attrs

  private

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end

end

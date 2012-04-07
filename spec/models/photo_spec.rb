require 'spec_helper'

describe Photo do
  
  # properties
  describe 'properties' do
    build_photo
    it 'should have a canonical title' do
      @photo.should respond_to :canonical_title
    end
  end
end

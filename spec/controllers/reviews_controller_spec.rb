require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  #create book before
  #auth user
  describe '#create' do
    it 'save review'
    it 'get success message after saving'
    it 'check user is auth'
    it 'should not save review to invalid book'
    it 'show error message after trying to save to invalid book'
  end
end

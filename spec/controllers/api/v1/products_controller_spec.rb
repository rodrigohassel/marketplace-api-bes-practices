require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe 'GET #show' do
    before(:each) do
      @product = FactoryBot.create :product
      get :show, params: { id: @product.id }
    end

    it 'return the information about a reporter on a hash' do
      product_response = json_response
      expect(product_response[:title]).to eq @product.title
    end

    it { should respond_with :ok }
  end  
end

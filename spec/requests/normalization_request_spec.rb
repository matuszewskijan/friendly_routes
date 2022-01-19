require 'spec_helper'

describe 'Normalization', type: :request do
  # NOTE: We had to monkey patch ActionDispatch::Routing::Mapper in dispatcher.rb to revert
  # changing URLs with all optional to require '/' at the beginning.
  # Here we ensure that requesting such route works.
  describe 'route with only optional params' do
    before do
      @cats = create :category, title: 'cats'
      @dogs = create :category, title: 'dogs'
      Rails.application.reload_routes!
    end

    it 'works for male only' do
      get all_optional_friendly_path(friendly_routes_male: 'male')
      expect(controller.params['male']).to eq('true')
      expect(assigns(:path)).to eq('/male')
    end

    it 'works for category only' do
      get all_optional_friendly_path(friendly_routes_category_id: 'cats')
      expect(controller.params['category_id']).to eq(@cats.id)
      expect(controller.params['male']).to eq(nil)
      expect(assigns(:path)).to eq('/cats')
    end

    it 'works for both optional params' do
      get all_optional_friendly_path(
        friendly_routes_male: 'female',
        friendly_routes_category_id: 'dogs'
      )
      expect(controller.params['category_id']).to eq(@dogs.id)
      expect(controller.params['male']).to eq('false')
      expect(assigns(:path)).to eq('/female/dogs')
    end
  end

  describe 'keep friendly route params in path' do
    before do
      boolean_param = build :boolean, name: 'male', statements: %w(male female)
      collection_param = build :collection
      @cats = create :category, title: 'cats'
      @dogs = create :category, title: 'dogs'
      Rails.application.reload_routes!
    end

    it 'male' do
      get friendly_url(friendly_routes_male: 'male')
      expect(controller.params['male']).to eq('true')
      expect(assigns(:path)).to eq("/male")
    end

    it 'female' do
      get friendly_url(friendly_routes_male: 'female')

      expect(controller.params['male']).to eq('false')
      expect(assigns(:path)).to eq('/female')
    end

    it 'cats' do
      get friendly_url(friendly_routes_category_id: 'cats',
                       friendly_routes_male: 'female')

      expect(assigns(:path)).to eq('/female/cats')
      expect(controller.params['male']).to eq('false')
      expect(controller.params['category_id']).to eq(@cats.id)
    end

    it 'dogs' do
      get friendly_url(friendly_routes_category_id: 'dogs',
                       friendly_routes_male: 'male')

      expect(assigns(:path)).to eq('/male/dogs')
      expect(controller.params['male']).to eq('true')
      expect(controller.params['category_id']).to eq(@dogs.id)
    end

    context 'other actions should preserve its own parameters' do
      it 'new action' do
        get friendly_url(friendly_routes_male: 'male')
        expect(assigns(:new_action_path)).to eq('/friendly/new?male=true')
      end

      it 'override friendly param' do
        get friendly_url(friendly_routes_male: 'male')
        expect(assigns(:path2)).to eq('/female')
      end
    end
  end
end

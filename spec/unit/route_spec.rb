require 'rails_helper'

module FriendlyRoutes
  describe Route do
    before do
      @controller = double('ItemsController')
    end
    describe '#initialize' do
      before do
        @method = 'get'
        @path = '/'
        @controller = 'items'
        @action = 'index'
        @params = []
      end

      def call
        Route.new(@method, @path, controller: @controller, action: @action)
      end

      describe 'should set instance variables' do
        [:method, :path, :controller, :action, :params].each do |variable|
          describe(variable) do
            let(:subject) { call.public_send(variable) }
            let(:value) { instance_variable_get("@#{variable}") }
            it { is_expected.to eq(value) }
          end
        end
      end
    end
    describe '#boolean' do
      before do
        @route = build(:route)
        @condition_name = :leaned
        @condition_params = { true: :leaned, false: :not_leaned }
        @route.boolean(@condition_name, @condition_params)
      end
      it 'should pass condition to params array' do
        expect(@route.params).to include(
          @condition_params.merge(
            type: :boolean,
            name: @condition_name
          )
        )
      end
    end

    describe '#path' do
      before do
        @original_path = '/'
        @route = build(:route, path: @original_path)
        @condition_name = Faker::Hipster.word
        @condition_params = { true: Faker::Hipster.word, false: Faker::Hipster.word }
        @route.boolean(@condition_name, @condition_params)
      end
      it 'should add conditions to path' do
        expect(@route.path).to eq(@original_path + ":friendly_routes_#{@condition_name}")
      end
    end
  end
end

require 'spec_helper'

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
        @prefix = 'custom_prefix'
        @params = []
      end

      def call
        Route.new(@method, @path, controller: @controller, action: @action, prefix: @prefix)
      end

      describe 'should set instance variables' do
        [:method, :path, :controller, :action, :params, :prefix].each do |variable|
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
      end
      context 'When correct params passed' do
        before do
          @condition_name = :leaned
          @condition_params = { true: :leaned, false: :not_leaned }
          @param = double('Param')
        end
        it 'should add boolean param to params array' do
          expect(Params::Boolean).to receive(:new).with(@condition_name, @condition_params) do
            @param
          end
          @route.boolean(@condition_name, @condition_params)
          expect(@route.params).to include(@param)
        end
      end
    end

    describe '#path' do
      before do
        @original_path = '/'
        @route = build(:route, path: @original_path)
        @param_name = Faker::Hipster.word
        @param_options = { true: Faker::Hipster.word, false: Faker::Hipster.word }
        @route.boolean(@param_name, @param_options)
      end
      it 'should add conditions to path' do
        expect(@route.path).to eq(@original_path + ":friendly_routes_#{@param_name}")
      end
    end

    describe '#constraints' do
      let(:subject) { @route.constraints }
      before do
        @route = build(:route, boolean_params: 2)
        @params = @route.params
      end
      it { is_expected.to be_a(Hash) }
      it 'should have all params' do
        expect(subject.size).to eq(2)
      end
    end
  end
end

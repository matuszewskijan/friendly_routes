require 'spec_helper'

describe DummiesController do
  describe 'Basic' do
    describe 'get #index' do
      it { expect(response).to be_successful }
    end
  end
  describe 'Friendly routes' do
    describe '#index' do
      describe 'boolean' do
        def stub_params(params)
          allow(controller).to receive(:params) { params }
        end
        before do
          @route = build(:route, boolean_params: 1)
          @param = @route.params.first
          @prefixed_name = FriendlyRoutes::PrefixedParam.new(@param.name, @route.prefix).call
          @params = {
            friendly_route: @route
          }
        end
        context 'When true value passed' do
          before do
            stub_params @params.merge(@prefixed_name => @param.true)
            get :index
          end
          it 'should set true value' do
            expect(controller.params[@param.name]).to eq('true')
          end
        end
        context 'When false value passed' do
          before do
            stub_params @params.merge(@prefixed_name => @param.false)
            get :index
          end
          it 'should set false value' do
            expect(controller.params[@param.name]).to eq('false')
          end
        end
      end
      describe 'collection' do
        def stub_params(params)
          allow(controller).to receive(:params) { params }
        end
        before do
          @route = build(:route)
          @param = build(:collection, items: 3)
          @route.params << @param
          @prefixed_name = FriendlyRoutes::PrefixedParam.new(@param.name, @route.prefix).call
          @params = {
            friendly_route: @route
          }
        end

        it 'should set id to params' do
          @param.collection.all.each do |item|
            stub_params @params.merge(@prefixed_name => item.public_send(@param.key_attr))
            get :index
            expect(controller.params[@param.name]).to eq(item.id)
          end
        end
      end

      describe 'hash' do
        def stub_params(params)
          allow(controller).to receive(:params) { params }
        end
        before do
          @route = build(:route)
          @param = FriendlyRoutes::Params::HashParams.new(
            :rooms,
            'one-roomed' => 1,
            'two-roomed' => 2
          )
          @route.params.push(@param)
          @prefixed_name = FriendlyRoutes::PrefixedParam.new(@param.name, @route.prefix).call
          @params = {
            friendly_route: @route
          }
        end

        it 'should set id to params' do
          @param.hash.each do |key, val|
            stub_params @params.merge(@prefixed_name => key)
            get :index
            expect(controller.params[@param.name]).to eq(val)
          end
        end
      end
    end
  end
end

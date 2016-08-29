require 'spec_helper'

describe DummiesController do
  describe 'Basic' do
    describe 'get #index' do
      it { expect(response).to be_success }
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
          @prefixed_name = @route.prefixed_param_name(@param)
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
            expect(controller.params[@param.name]).to be true
          end
        end
        context 'When false value passed' do
          before do
            stub_params @params.merge(@prefixed_name => @param.false)
            get :index
          end
          it 'should set false value' do
            expect(controller.params[@param.name]).to be false
          end
        end
      end
    end
  end
end

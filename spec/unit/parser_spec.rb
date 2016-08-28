require 'rails_helper'

module FriendlyRoutes
  describe Parser do
    describe 'Parsing boolean params' do
      before do
        @route = build(:route, boolean_conditions: 1)
        @param = @route.params.first
        @params = {
          friendly_route: @route
        }
      end
      context 'When value is true' do
        before do
          @params[@route.prefixed_param_name(@param)] = @param[:true]
          parser = Parser.new(@params)
          parser.call
        end
        it 'should set true to params' do
          expect(@params[@param[:name]]).to be true
        end
      end
      context 'When value is false' do
        before do
          @params[@route.prefixed_param_name(@param)] = @param[:false]
          parser = Parser.new(@params)
          parser.call
        end
        it 'should set false to params' do
          expect(@params[@param[:name]]).to be false
        end
      end
    end
  end
end

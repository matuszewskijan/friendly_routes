require 'spec_helper'

module FriendlyRoutes
  describe Parser do
    def set_param(param, attribute)
      @params[prefixed_name(param)] = param.public_send(attribute)
    end

    def prefixed_name(param)
      FriendlyRoutes::PrefixedParam.new(param.name, @route.prefix).call
    end
    before do
      @route = build(:route, boolean_params: 2)
      @params = {
        friendly_route: @route
      }
      set_param(@route.params.first, :true)
      set_param(@route.params.last, :false)
    end

    it 'should add params with correct values' do
      Parser.new(@params, false).call
      expect(@params).to include(
        @route.params.first.name => true, @route.params.last.name => false
      )
    end

    context 'when keep_all == true' do
      it 'should not delete friendly_route params' do
        Parser.new(@params, true).call
        expect(@params.keys).to include(
          prefixed_name(@route.params.first),
          prefixed_name(@route.params.last)
        )
      end
    end

    context 'when keep_all == false' do
      it 'should delete friendly_route params' do
        Parser.new(@params, false).call
        expect(@params.keys).not_to include(
          prefixed_name(@route.params.first),
          prefixed_name(@route.params.last)
        )
      end
    end
  end
end

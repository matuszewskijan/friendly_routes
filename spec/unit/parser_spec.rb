require 'spec_helper'

module FriendlyRoutes
  describe Parser do
    def set_param(param, method)
      @params[@route.prefixed_param_name(param)] = param.public_send(method)
    end
    before do
      @route = build(:route, boolean_params: 2)
      @params = {
        friendly_route: @route
      }
      set_param(@route.params.first, :true)
      set_param(@route.params.last, :false)
      Parser.new(@params).call
    end

    it 'should add update params with correct values' do
      expect(@params).to include(
        @route.params.first.name => true, @route.params.last.name => false
      )
    end
  end
end

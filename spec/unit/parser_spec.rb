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
      Parser.new(@params).call
    end

    it 'should add params with correct values' do
      expect(@params).to include(
        @route.params.first.name => true, @route.params.last.name => false
      )
    end

    it 'should delete friendly_route params' do
      names = @route.params.map do |param|
        prefixed_name(param)
      end
      expect(@params).not_to include(names)
    end
  end
end

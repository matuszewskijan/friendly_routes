require 'spec_helper'

module FriendlyRoutes
  describe Dispatcher do
    describe '#friendly_url_for' do
      let(:subject) { (Class.new { include Dispatcher }).new }
      let(:method) { [:get, :post, :put, :delete].sample }
      before do
        @controller = 'items'
        @action = 'index'
        @route = Route.new('/', controller: @controller, action: @action)
      end
      it 'should call method with router params' do
        expect(subject).to receive(method).with(
          @route.path,
          controller: @controller,
          action: @action,
          friendly_route: @route,
          as: @route.as,
          constraints: @route.constraints
        )
        expect(subject.friendly_url_for(@route, method))
      end
    end
  end
end

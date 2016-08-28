require 'rails_helper'

module FriendlyRoutes
  describe Dispatcher do
    describe '#friendly_url_for' do
      let(:subject) { (Class.new { include Dispatcher }).new }
      before do
        @controller = 'items'
        @action = 'index'
        @route = Route.new(:get, '/', controller: @controller, action: @action)
      end
      it 'should call method with router params' do
        expect(subject).to receive(:get).with(
          @route.path,
          controller: @controller,
          action: @action,
          friendly_route: @route,
          as: @route.as
        )
        expect(subject.friendly_url_for(@route))
      end
    end
  end
end

require 'spec_helper'

module FriendlyRoutes
  describe Dispatcher do
    describe '#friendly_url_for' do
      let(:subject) { (Class.new { include Dispatcher }).new }
      let(:method) { [:get, :post, :put, :delete].sample }
      let(:route_name) { Faker::Lorem.word }
      let(:path) { '/' }

      before do
        @controller = 'items'
        @action = 'index'
        @route = build(:route)
      end

      it 'should call method with router params' do
        @route.params << build(:collection)
        expect(subject).to receive(method).with(
          path + @route.path,
          controller:     @controller,
          action:         @action,
          friendly_route: @route,
          as:             @route_name,
          constraints:    @route.constraints
        )

        subject.friendly_url_for @route, method, path,
          controller: @controller,
          action:     @action,
          as:         @route_name
      end

      it 'should just return if table not exist' do
        @route.params << build(:collection, collection: 'fake')
        expect(subject).to_not receive(method)

        subject.friendly_url_for @route, method, path,
          controller: @controller,
          action:     @action,
          as:         @route_name
      end
    end
  end
end

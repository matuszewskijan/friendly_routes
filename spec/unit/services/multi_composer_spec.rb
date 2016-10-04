require 'spec_helper'

module FriendlyRoutes
  describe MultiComposer do
    def prefixed_name(route, param)
      FriendlyRoutes::PrefixedParam.new(param.name, route.prefix).call
    end
    before do
      @boolean_param = build(:boolean, :required)
      @collection_param = build(:collection, :required)
      @mixed_route = build(:route, params: [@boolean_param, @collection_param])
      @boolean_route = build(:route, params: [@boolean_param])
      @collection_route = build(:route, params: [@collection_param])
      create_list(:category, 2)
      @routes = [
        @mixed_route,
        @boolean_route,
        @collection_route
      ]
    end

    context 'When matches mixed_route' do
      subject { MultiComposer.new(@routes, @params) }
      before do
        @params = {
          @boolean_param.name => true,
          @collection_param.name => @collection_param.collection.first.id
        }
      end
      it 'should return params' do
        expect(subject.call).to include(
          prefixed_name(@mixed_route, @boolean_param) => @boolean_param.true,
          prefixed_name(@mixed_route, @collection_param) => @collection_param.collection.first.title
        )
      end

      it 'should return set matched_route' do
        subject.call
        expect(subject.matched_route).to equal(@mixed_route)
      end
    end

    context 'When matches boolean_route' do
      subject { MultiComposer.new(@routes, @params) }
      before do
        @params = {
          @boolean_param.name => false
        }
      end
      it 'should return params' do
        expect(subject.call).to include(
          prefixed_name(@boolean_route, @boolean_param) => @boolean_param.false
        )
      end

      it 'should return set matched_route' do
        subject.call
        expect(subject.matched_route).to equal(@boolean_route)
      end
    end

    context 'When matches collection_route' do
      subject { MultiComposer.new(@routes, @params) }
      before do
        @params = {
          @collection_param.name => @collection_param.collection.last.id
        }
      end
      it 'should return params' do
        expect(subject.call).to include(
          prefixed_name(@collection_route, @collection_param) =>
            @collection_param.collection.last.title
        )
      end

      it 'should return set matched_route' do
        subject.call
        expect(subject.matched_route).to equal(@collection_route)
      end
    end
  end
end

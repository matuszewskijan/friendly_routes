require 'spec_helper'

module FriendlyRoutes
  describe Composer do
    describe '#call' do
      before do
        @route = build(:route, boolean_params: 2)
        @mapped_params = {
          @route.params.first.name => true,
          @route.params.last.name => false
        }
      end

      it 'should return hash with correct request params' do
        expect(Composer.new(@route, @mapped_params).call).to include(
          prefixed_name(@route.params.first) => @route.params.first.true,
          prefixed_name(@route.params.last) => @route.params.last.false
        )
      end
    end
    describe '#can_be_composed?' do
      before do
        @route = build(:route)
        @param = build(:boolean, :required)
        @route.params << @param
      end

      context 'when required param passed' do
        context 'valid param' do
          subject { Composer.new(@route, @param.name => Faker::Boolean.boolean).can_be_composed? }
          it { is_expected.to eq(true) }
        end

        context 'invalid param' do
          subject { Composer.new(@route, @param.name => Faker::Lorem.word).can_be_composed? }
          it { is_expected.to eq(false) }
        end
      end

      context 'when required param not passed' do
        it { expect(Composer.new(@route).can_be_composed?).to eq(false) }
      end
    end
    def prefixed_name(param)
      FriendlyRoutes::PrefixedParam.new(param.name, @route.prefix).call
    end
  end
end

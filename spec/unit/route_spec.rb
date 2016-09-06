require 'spec_helper'

module FriendlyRoutes
  describe Route do
    describe '#initialize' do
      subject { Route.new(@params, prefix: @prefix) }
      before do
        @prefix = Faker::Lorem.word
        @params = []
      end

      it 'shoud set prefix instance variable' do
        expect(subject.prefix).to eq(@prefix)
      end

      it 'shoud set params instance variable' do
        expect(subject.params).to eq(@params)
      end
    end

    describe '#constraints' do
      before do
        @route = build(:route, boolean_params: 2)
      end
      it 'should return Constraints hash' do
        constraints = double('Constraints')
        constraints_hash = double('constraints_hash')
        expect(FriendlyRoutes::Constraints).to(
          receive(:new).with(@route.dynamic_params, @route.prefix)
        ).and_return(constraints)
        expect(constraints).to receive(:call) { constraints_hash }
        expect(@route.constraints).to eq(constraints_hash)
      end
    end
  end
end

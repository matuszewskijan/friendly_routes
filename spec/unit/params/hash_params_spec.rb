require 'spec_helper'

module FriendlyRoutes
  module Params
    describe HashParams do
      describe '#initialize' do
        context 'When passed not hash' do
          it 'should raise ArgumentError' do
            expect { Params::HashParams.new(Faker::Hipster.word, :hash) }.to(
              raise_error(ArgumentError)
            )
          end
        end
      end
      describe '#constraints' do
        before do
          @subject = Params::HashParams.new(:rooms, 'one-roomed' => 1, 'two-roomed' => 2)
        end
        it 'should return Regexp with keys' do
          expect(@subject.constraints).to eq(/one-roomed|two-roomed/)
        end
      end
    end
  end
end

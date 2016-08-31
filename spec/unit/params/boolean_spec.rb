require 'spec_helper'

module FriendlyRoutes
  module Params
    describe Boolean do
      describe '#initialize' do
        context 'When correct params not passed' do
          shared_examples 'failed creation' do |params|
            it 'should raise ArgumentError' do
              expect { Boolean.new(Faker::Hipster.word, params) }.to raise_error(ArgumentError)
            end
          end
          context 'When only true passed' do
            it_behaves_like 'failed creation', true: Faker::Hipster.word
          end
          context 'When only false passed' do
            it_behaves_like 'failed creation', false: Faker::Hipster.word
          end
          context 'When empty hash passed' do
            it_behaves_like 'failed creation', {}
          end
          context 'When options not passed' do
            it_behaves_like 'failed creation', nil
          end
        end
      end
      describe '#constraints' do
        before do
          @true = Faker::Lorem.word
          @false = Faker::Lorem.word
          @subject = Boolean.new(:name, true: @true, false: @false)
        end
        it 'should return Regexp with true or false value' do
          expect(@subject.constraints).to eq(/#{@true}|#{@false}/)
        end
      end
      describe '#parse' do
        before do
          @true = Faker::Lorem.word
          @false = Faker::Lorem.word
          @subject = Boolean.new(:name, true: @true, false: @false)
        end
        context 'When value is true' do
          it 'should return true' do
            expect(@subject.parse(@true)).to be true
          end
        end
        context 'When value is false' do
          it 'should return false' do
            expect(@subject.parse(@false)).to be false
          end
        end
      end
    end
  end
end

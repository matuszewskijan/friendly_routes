# frozen_string_literal: true
require 'spec_helper'

module FriendlyRoutes
  module Params
    describe BooleanParams do
      describe '#initialize' do
        context 'When correct params not passed' do
          shared_examples 'failed creation' do |params|
            it 'should raise ArgumentError' do
              expect { BooleanParams.new(Faker::Hipster.word, params) }.to raise_error(ArgumentError)
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
          @true, @false = Faker::Lorem.words(number: 2)
          @subject = BooleanParams.new(:name, true: @true, false: @false)
        end
        it 'should return Regexp with true or false value' do
          expect(@subject.constraints).to eq(/#{@true}|#{@false}/)
        end
      end
      describe '#parse' do
        before do
          @true, @false = Faker::Lorem.words(number: 2)
          @subject = BooleanParams.new(:name, true: @true, false: @false)
        end
        context 'When value is true' do
          it 'should return true' do
            expect(@subject.parse(@true)).to eq('true')
          end
        end
        context 'When value is false' do
          it 'should return false' do
            expect(@subject.parse(@false)).to eq('false')
          end
        end
      end

      describe '#compose' do
        before do
          @true, @false = Faker::Lorem.words(number: 2)
          @subject = BooleanParams.new(:name, true: @true, false: @false)
        end
        context 'When composing true' do
          it 'should return value of true' do
            expect(@subject.compose(true)).to eq(@true)
          end
        end
        context 'When composing false' do
          it 'should return false' do
            expect(@subject.compose(false)).to eq(@false)
          end
        end
      end

      describe '#allowed?' do
        before do
          @true, @false = Faker::Lorem.words(number: 2)
          @subject = BooleanParams.new(:name, true: @true, false: @false)
        end
        context 'When passed true or false' do
          it 'should return true' do
            expect(@subject.allowed?(true)).to be(true)
            expect(@subject.allowed?(false)).to be(true)
          end
        end
        context 'When passed not true or false' do
          it 'should return false' do
            expect(@subject.allowed?('not-true')).to be(false)
            expect(@subject.allowed?(nil)).to be(false)
            expect(@subject.allowed?(1)).to be(false)
          end
        end
      end
    end
  end
end

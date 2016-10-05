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

      describe '#parse' do
        before do
          @params = { 'one-roomed' => 1, 'two-roomed' => 2 }
          @subject = Params::HashParams.new(:rooms, @params)
        end
        it 'should return string value by key for any member' do
          @params.each do |key, value|
            expect(@subject.parse(key)).to eq(value.to_s)
          end
        end
      end

      describe '#compose' do
        before do
          @params = { 'one-roomed' => 1, 'two-roomed' => 2 }
          @subject = Params::HashParams.new(:rooms, @params)
        end
        it 'should return key by value for any member' do
          @params.each do |key, value|
            expect(@subject.compose(value)).to eq(key)
          end
        end
      end

      describe '#allowed?' do
        before do
          @params = { 'one-roomed' => 1, 'two-roomed' => 2 }
          @subject = Params::HashParams.new(:rooms, @params)
        end
        context 'When passed value from hash' do
          it 'should return true' do
            @params.values.each do |value|
              expect(@subject.allowed?(value)).to be(true)
            end
          end
        end
        context 'When passed incorrect value' do
          it 'should return false' do
            expect(@subject.allowed?(Faker::Lorem.word)).to be(false)
          end
        end
      end
    end
  end
end

require 'spec_helper'

module FriendlyRoutes
  module Params
    describe Collection do
      describe '#initialize' do
        context 'When correct params not passed' do
          shared_examples 'failed creation' do |collection, method|
            it 'should raise ArgumentError' do
              expect do
                Collection.new(Faker::Hipster.word, collection, method)
              end.to raise_error(ArgumentError)
            end
          end
          context 'When only collection not passed' do
            it_behaves_like 'failed creation', nil
          end
          context 'When only collection not respond to mehod' do
            it_behaves_like 'failed creation', Class.new, :undefined_method
          end
        end
      end
      describe '#constraints' do
        before do
          create_list(:category, 3)
          @categories = Category
          @subject = Collection.new(:category, @categories, :title)
        end
        it 'should return Regexp with titles' do
          regexp = Regexp.new(@categories.all.map(&:title).join('|'))
          expect(@subject.constraints).to eq(regexp)
        end
      end
      describe '#parse' do
        before do
          @categories = create_list(:category, 3)
          @subject = Collection.new(:category, Category, :title)
        end
        it 'should return id of passed item for any item' do
          @categories.each do |category|
            expect(@subject.parse(category.title)).to eq(category.id)
          end
        end
      end
    end
  end
end

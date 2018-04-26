require 'spec_helper'

module FriendlyRoutes
  module Params
    describe CollectionParams do
      describe '#initialize' do
        shared_examples 'failed creation' do
          it 'should raise ArgumentError' do
            expect do
              CollectionParams.new(Faker::Hipster.word, collection, method)
            end.to raise_error(ArgumentError, message)
          end
        end

        context 'when collection not passed' do
          include_examples 'failed creation' do
            let(:collection) { nil }
            let(:method) { :get }
            let(:message) { 'Collection or key attribute not passed' }
          end
        end

        context 'when method not passed' do
          include_examples 'failed creation' do
            let(:collection) { Class.new }
            let(:method) { nil }
            let(:message) { 'Collection or key attribute not passed' }
          end
        end

        context 'collection not respond to :to_s' do
          include_examples 'failed creation' do
            let(:collection) do
              collection = Class.new
              allow(collection).to receive(:respond_to?) { false }
              collection
            end
            let(:method) { :get }
            let(:message) { 'Collection should respond to :to_s' }
          end
        end
      end

      describe '#constraints' do
        before do
          create_list(:category, 3)
          @categories = Category
          @subject = CollectionParams.new(:category, @categories, :title)
        end
        it 'should return Regexp with titles' do
          regexp = Regexp.new(@categories.all.map(&:title).join('|'))
          expect(@subject.constraints).to eq(regexp)
        end
      end
      describe '#parse' do
        before do
          @categories = create_list(:category, 3)
          @subject = CollectionParams.new(:category, Category, :title)
        end
        it 'should return id of passed item for any item' do
          @categories.each do |category|
            expect(@subject.parse(category.title)).to eq(category.id)
          end
        end
      end

      describe '#compose' do
        before do
          @categories = create_list(:category, 3)
          @subject = CollectionParams.new(:category, Category, :title)
        end
        context 'when id passed' do
          it 'should return title of passed item for any item' do
            @categories.each do |category|
              expect(@subject.compose(category.id)).to eq(category.title)
            end
          end
        end
        context 'when instance passed' do
          it 'should return title of passed item for any item' do
            @categories.each do |category|
              expect(@subject.compose(category)).to eq(category.title)
            end
          end
        end
      end

      describe '#allowed?' do
        context 'when id passed' do
          before do
            @categories = create_list(:category, 3)
            @subject = CollectionParams.new(:category, Category, :title)
          end
          context 'When passed id existing in collection' do
            it 'should return true' do
              @categories.each do |category|
                expect(@subject.allowed?(category.id)).to be(true)
              end
            end
          end
          context 'When passed incorrect id' do
            it 'should return false' do
              expect(@subject.allowed?(@categories.count.next)).to be(false)
            end
          end
        end
        context 'when instance passed' do
          before do
            @collecion_categories = create_list(:category, 2)
            @subject = CollectionParams.new(:category, Category.where('id < 3'), :title)
          end
          context 'When passed instance existing in collection' do
            it 'should return true' do
              @collecion_categories.each do |category|
                expect(@subject.allowed?(category)).to be(true)
              end
            end
          end
          context 'When passed incorrect instance' do
            it 'should return false' do
              expect(@subject.allowed?(create(:category))).to be(false)
            end
          end
        end
      end
    end
  end
end

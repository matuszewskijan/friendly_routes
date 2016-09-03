require 'spec_helper'

module FriendlyRoutes
  describe Route do
    before do
      @controller = double('ItemsController')
    end
    describe '#initialize' do
      before do
        @path = '/'
        @controller = 'items'
        @action = 'index'
        @prefix = 'custom_prefix'
        @params = []
      end

      def call
        Route.new(@path, controller: @controller, action: @action, prefix: @prefix)
      end

      describe 'should set instance variables' do
        [:path, :controller, :action, :params, :prefix].each do |variable|
          describe(variable) do
            let(:subject) { call.public_send(variable) }
            let(:value) { instance_variable_get("@#{variable}") }
            it { is_expected.to eq(value) }
          end
        end
      end
    end
  end
end

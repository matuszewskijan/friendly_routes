describe FriendlyRoutes::PrefixedParams do
  before do
    @prefix = Faker::Lorem.word
    @param_name = Faker::Hipster.word
    @param_options = { true: Faker::Hipster.word, false: Faker::Hipster.word }
  end

  def boolean(name, options, optional: false)
    FriendlyRoutes::Params::BooleanParams.new(name, options, optional: optional)
  end

  describe '#to_s' do
    subject { FriendlyRoutes::PrefixedParams.new(@params, @prefix).to_s }

    context 'required param' do
      before do
        @params = [boolean(@param_name, @param_options, optional: false)]
      end

      it 'should add required condition to path' do
        is_expected.to eq(":#{@prefix}_#{@param_name}")
      end
    end

    context 'optional param' do
      before do
        @params = [boolean(@param_name, @param_options, optional: true)]
      end

      it 'should add optional condition to path' do
        is_expected.to eq("(:#{@prefix}_#{@param_name})")
      end
    end

    context 'string' do
      before do
        @param = Faker::Lorem.word
        @params = [@param]
      end

      it 'should add string to path' do
        is_expected.to eq(@param)
      end
    end
  end
  describe '#call' do
    subject { FriendlyRoutes::PrefixedParams.new(@params, @prefix).call }

    before do
      @params = [boolean(@param_name, @param_options, optional: false)]
    end

    it 'should return hash of prefixed params' do
      is_expected.to match_array(["#{@prefix}_#{@param_name}".to_sym])
    end
  end
end

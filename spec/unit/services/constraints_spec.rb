describe FriendlyRoutes::Constraints do
  describe '#call' do
    let(:subject) { FriendlyRoutes::Constraints.new(@params, @prefix).call }
    before do
      @prefix = Faker::Lorem.word
    end
    context 'single param' do
      before do
        @param = build(:boolean)
        @params = [@param]
      end
      it { is_expected.to eq("#{@prefix}_#{@param.name}".to_sym => @param.constraints) }
    end
    context 'multiple params' do
      before do
        @params = Faker::Lorem.words(2).map { |word| build(:boolean, name: word) }
      end
      it { is_expected.to be_a(Hash) }
      it 'should have all params' do
        expect(subject.size).to eq(2)
      end
    end
  end
end

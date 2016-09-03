describe FriendlyRoutes::Constraints do
  let(:subject) { FriendlyRoutes::Constraints.new(@params, @prefix).call }
  before do
    @prefix = Faker::Lorem.word
    @params = build_list(:boolean, 2)
  end
  it { is_expected.to be_a(Hash) }
  it 'should have all params' do
    expect(subject.size).to eq(2)
  end
end

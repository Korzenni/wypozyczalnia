describe User do

  let(:user) { create(:user) }

  subject { user }

  it { should respond_to(:email) }

  it { should respond_to(:business_partner?) }

  it "#email returns a string" do
    expect(subject.email).to match 'test@example.com'
  end

  describe "has no company" do
    it "#business_partner? should return false" do
      expect(subject.business_partner?).to eq false
    end
  end

  describe "has company" do
    before do
      user.companies.create(name: "Test")
    end

    it "#business_partner? should return true" do
      expect(user.business_partner?).to eq true
    end
  end

end

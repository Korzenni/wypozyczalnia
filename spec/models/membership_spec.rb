describe Membership do
  let(:membership) { create(:membership) }

  subject { membership }

  describe "without role" do
    before { membership.role = "" }
    it { should_not be_valid }
  end
end

describe Company do
  let(:company) { create(:company) }

  subject { company }

  it { should respond_to(:users) }

  describe "without name" do
    before { company.name = "" }
    it { should_not be_valid }
  end

end

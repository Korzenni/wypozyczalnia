describe User do

  let(:user) { create(:user) }

  subject { user }

  it { should respond_to(:email) }

  it { should respond_to(:business_partner?) }

  describe "has no company" do
    it "#business_partner? should return false" do
      expect(subject.business_partner?).to eq false
    end

    it "#role should return nil" do
      expect(subject.role).to eq nil
    end
  end

  describe "has company" do
    before do
      user.companies.create(name: "Test")
    end

    it "#business_partner? should return true" do
      expect(user.business_partner?).to eq true
    end

    it "#company should return its first company" do
      expect(user.company).to eq user.companies.first
    end

    it "#role returns users role in company" do
      expect(user.role).to eq user.memberships.first.role
    end

    context "and is owner of this company" do
      before { user.memberships.first.update_attributes(role: 2) }
      it "#is_owner? returns true" do
        expect(subject.is_owner?).to eq true
      end
    end

    context "and is owner or admin of this company" do
      it "#has_permissions? return true if admin" do
        user.memberships.first.update_attributes(role: 2)
        expect(subject.has_permissions?).to eq true
      end

      it "#has_permissions? return true if owner" do
        user.memberships.first.update_attributes(role: 1)
        expect(subject.has_permissions?).to eq true
      end

      it "#has_permissions? return false if user" do
        user.memberships.first.update_attributes(role: 0)
        expect(subject.has_permissions?).to eq false
      end
    end

    it "#toggle_role! toggles role from admin to user and back" do
      user.memberships.first.update_attributes(role: 0)
      expect { subject.toggle_role! }.to change { subject.role }.to(1)
      expect { subject.toggle_role! }.to change { subject.role }.to(0)
      user.memberships.first.update_attributes(role: 2)
      expect { subject.toggle_role! }.to raise_error
    end
  end

end

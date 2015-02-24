require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let!(:user) { create(:user) }
  let(:correct_params) do
    {
      user: {
        email: 'test@email.com',
        password: '12345678',
        password_confirmation: '12345678',
        companies_attributes: [
          {
            name: 'Test company'
          }
        ]
      }
    }
  end

  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET new_company" do
    let(:get_new_company) { get :new_company }

    subject { get_new_company }

    context "when user is signed in" do
      before { sign_in user }

      it "redirects to root path with proper flash message" do
        expect(subject).to redirect_to root_path
        expect(subject.request.flash[:notice]).to be_present
      end
    end

    context "when user is not signed in" do
      it "exposes new user with one company" do
        expect{ get_new_company }.to change{ assigns(:user) }.to be_a_new(User)
      end
    end
  end

  describe "POST create_company" do
    let(:post_create_company) { post :create_company, correct_params }

    subject { post_create_company }

    context "when user is signed in" do
      before { sign_in user }

      it "redirects to root path with proper flash message" do
        expect(subject).to redirect_to root_path
        expect(subject.request.flash[:notice]).to be_present
      end
    end

    context "when user is not signed in" do
      context "with proper params" do
        it "creates user with proper membership" do
          expect{ post_create_company }.to change { User.count }.by(1)
          expect(User.last.memberships.last.role).to eq 2
        end
        it "creates company" do
          expect{ post_create_company }.to change { Company.count }.by(1)
        end
      end
    end
  end
end

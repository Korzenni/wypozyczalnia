require 'rails_helper'

RSpec.describe Users::InvitationsController, type: :controller do
  let!(:user) { create(:user) }

  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET new" do
    let(:get_new) { get :new }

    subject { get_new }

    context "when user is not logged in" do
      it "redirects to root path with proper flash message" do
        expect(subject).to redirect_to new_user_session_path
      end
    end

    context "when user is logged in" do
      before { sign_in user }

      context "and is a business partner" do
        before { user.companies.create(name: "Test") }

        it "responses with success" do
          expect(subject).to have_http_status(200)
        end

        it "exposes new user" do
          expect{ get_new }.to change{ assigns(:user) }.to be_a_new(User)
        end
      end

      context "and is not a business partner" do
        it "redirects to root path with proper flash message" do
          expect(subject).to redirect_to root_path
          expect(subject.request.flash[:notice]).to be_present
        end
      end
    end
  end

  describe "POST create" do
    let(:params) do
      {
        user: {
          email: "proper@email.com"
        }
      }
    end

    let(:already_signed_up_params) do
      {
        user: {
          email: "already@signedup.com"
        }
      }
    end

    let(:already_within_company) do
      {
        user: {
          email: "already@incompany.com"
        }
      }
    end

    let(:already_invited) do
      {
        user: {
          email: "already@invited.com"
        }
      }
    end

    let(:post_create) { post :create, params }
    let(:post_create_signed_up) { post :create, already_signed_up_params }
    let(:post_create_in_company) { post :create, already_within_company }
    let(:post_create_invited) { post :create, already_invited }

    subject { post_create }

    context "when user is not logged in" do
      it "redirects to root path with proper flash message" do
        expect(subject).to redirect_to new_user_session_path
      end
    end

    context "when user is logged in" do
      before { sign_in user }

      context "and is a business partner" do
        before { user.companies.create(name: "Test") }

        context "with not taken already user" do
          it "creates new user with proper membership" do
            expect { subject }.to change { User.count }.by(1)
            new_user = User.last
            expect(new_user.company).to eq user.company
            expect(new_user.role).to eq 0
          end
        end

        context "with already taken email address not within company" do
          let!(:existing_user) { create(:user, email: "already@signedup.com") }

          it "does not create neither memberships nor users" do
            expect { post_create_signed_up }.to_not change { Membership.count }
            expect { post_create_signed_up }.to_not change { User.count }
            expect(existing_user.company).to eq nil
          end
        end

        context "with already taken email address within company" do
          let!(:within_company_user) { create(:user, email: "already@incompany.com") }

          before do
            within_company_user.update_attributes(last_sign_in_at: DateTime.now)
            within_company_user.companies << user.company
          end

          it "does not create neither memberships nor users" do
            expect { post_create_in_company }.to_not change { within_company_user }
            expect { post_create_in_company }.to_not change { Membership.count }
          end
        end

        context "with already invited user" do
          let!(:invited_user) { create(:user, email: "already@invited.com") }

          before do
            invited_user.companies << user.company
          end

          it "does not create neither memberships nor users" do
            expect { post_create_invited }.to_not change { User.count }
            expect { post_create_invited }.to_not change { Membership.count }
          end
        end
      end

      context "and is not a business partner" do
        it "redirects to root path with proper flash message" do
          expect(subject).to redirect_to root_path
          expect(subject.request.flash[:notice]).to be_present
        end
      end
    end
  end
end

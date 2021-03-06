require 'rails_helper'

RSpec.describe Business::UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:owner) { create(:user) }
  let!(:company) { create(:company) }

  describe "GET index" do
    let(:get_index) { get :index }

    subject { get_index }

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
      end

      context "and is not a business partner" do
        it "redirects to root path with proper flash message" do
          expect(subject).to redirect_to root_path
          expect(subject.request.flash[:notice]).to be_present
        end
      end
    end
  end

  describe "POST toggle_role" do
    let(:post_toggle_role) { post :toggle_role, id: '2' }

    subject { post_toggle_role }

    context "when user is not logged in" do
      it "redirects to root path with proper flash message" do
        expect(subject).to redirect_to new_user_session_path
      end
    end

    context "when user is logged in" do
      before { sign_in user }

      context "and is a business partner" do
        before { company.users << user }

        context "and has proper permissions" do
          before do
            user.memberships.first.update_attributes(role: 1)
            company.users.create(email: "test@test.pl", password: '12345678')
            company.users << owner
            owner.memberships.first.update_attributes(role: 2)
            company.users.create(email: "test@test.pl", password: '12345678')
          end

          it "allows to toggle role of exisiting user who is not an owner" do
            expect { post :toggle_role, id: user.company.users.last.id }.to change { user.company.users.last.role }.to(1)
          end

          it "does not allow to toggle role of oneself" do
            expect { post :toggle_role, id: user.id }.to_not change { user.role }
          end

          it "does not allow to toggle role of owner" do
            expect { post :toggle_role, id: owner.id }.to_not change { user.role }
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

  describe "DELETE destroy" do
    let(:delete_destroy) { delete :destroy, id: '1' }

    subject { delete_destroy }

    context "when user is not logged in" do
      it "redirects to root path with proper flash message" do
        expect(subject).to redirect_to new_user_session_path
      end
    end

    context "when user is logged in" do
      before { sign_in user }

      context "and is a business partner" do
        before { company.users << user }

        context "and has proper permissions" do
          before do
            user.memberships.first.update_attributes(role: 1)
            user.company.users.create(email: "test@test.pl", password: '12345678')
          end

          it "allows to delete user with success" do
            expect { delete :destroy, id: user.company.users.last.id }.to change { user.company.users.count }.by(-1)
          end

          it "does not allow to delete oneself" do
            expect { delete :destroy, id: user.id }.to_not change { user.company.users.count }
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

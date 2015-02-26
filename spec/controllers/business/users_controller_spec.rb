require 'rails_helper'

RSpec.describe Business::UsersController, type: :controller do
  let!(:user) { create(:user) }

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
end

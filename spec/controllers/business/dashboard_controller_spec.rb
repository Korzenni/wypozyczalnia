require 'rails_helper'

RSpec.describe Business::DashboardController, type: :controller do
  let!(:user) { create(:user) }

  describe "GET show" do
    let(:get_show) { get :show }

    subject { get_show }

    context "when user is signed in" do
      before { sign_in user }

      context "but is no business partner" do
        it "redirects to root path with proper flash message" do
          expect(subject).to redirect_to root_path
          expect(subject.request.flash[:notice]).to be_present
        end
      end

      context "and is business partner" do
        before { user.companies.create(name: "Test") }

        it "responses with success" do
          expect(subject).to have_http_status(200)
        end
      end
    end

    context "when user is not signed in" do
      it "redirects to root path with proper flash message" do
        expect(subject).to redirect_to new_user_session_path
      end
    end
  end
end

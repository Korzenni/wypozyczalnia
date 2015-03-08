require 'rails_helper'

RSpec.describe Business::ItemsController, type: :controller do
  let(:user) { create(:user) }

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

  describe "POST create" do
    let(:params) do
      {
        item: {
          name: "Test",
          price: "10",
          deposit: "5",
          inventory_number: "XXX1234",
          item_category: ""
        }
      }
    end
    let(:post_create) { post :create, params }

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

        it "responses with success" do
          expect(post :create, params).to have_http_status(302)
          expect { post :create, params }.to change { Item.count }.by(1)
          expect { post :create, params }.to_not change { ItemCategory.count }
        end

        context "when provided item category id" do
          let(:params) do
            {
              item: {
                name: "Test",
                price: "10",
                deposit: "5",
                inventory_number: "XXX1234",
                item_category: "1"
              }
            }
          end

          it "does not create new item category" do
            expect(post :create, params).to have_http_status(302)
            expect { post :create, params }.to change { Item.count }.by(1)
            expect { post :create, params }.to_not change { ItemCategory.count }
          end
        end

        context "when provided item category name" do
          let(:params) do
            {
              item: {
                name: "Test",
                price: "10",
                deposit: "5",
                inventory_number: "XXX1234",
                item_category: "New category"
              }
            }
          end

          it "creates new item category" do
            expect(post :create, params).to have_http_status(302)
            expect { post :create, params }.to change { Item.count }.by(1)
            expect { post :create, params }.to change { ItemCategory.count }.by(1)
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

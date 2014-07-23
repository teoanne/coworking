require 'rails_helper'

describe ResetPasswordsController do

  describe "GET show" do
      context "valid user token" do
        it "displays the reset password page" do
          foo = Fabricate(:user)
          foo.update_column(:token, '12345')
          get :show, id: '12345'
          expect(response).to render_template :show
        end

        it "sets @token" do #to track hidden field
          foo = Fabricate(:user)
          foo.update_column(:token, '12345')
          get :show, id: '12345'
          expect(assigns(:token)).to eq("12345")
        end
      end

    context "invalid user token" do
      it "displays the invalid link page" do
        get :show, id: "12543"
        expect(response).to redirect_to invalid_token_path
      end
    end
  end #ends GET show

  describe "POST create" do
    context "valid token" do

      it "changes the user's password" do
        foo = Fabricate(:user)
        foo.update_column(:token, '12345')
        post :create, token: '12345', password: 'password'
        expect(foo.reload.authenticate('new_password')).to be_true
      end

      it "redirects to the user sign in page" do
        foo = Fabricate(:user, password: "abcdefgh")
        foo.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(response).to redirect_to login_path
      end

      it "displays a flash message asking user to sign in with new password" do
        foo = Fabricate(:user, password: "abcdefgh")
        foo.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(flash[:success]).to be_present
      end

      it "regenerates the user token" do # as a security measure, so that other ppl cannot reuse token
        foo = Fabricate(:user, password: "abcdefgh")
        foo.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(foo.reload.token).not_to eq("12345")
      end
    end

    context "invalid invalid" do
      it "redirects to invalid token path" do
        post :create, token: "12345", password: "new_password"
        expect(response).to redirect_to invalid_token_path
      end
    end
  end #ends POST create
end
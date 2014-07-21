require 'rails_helper'

describe ForgotPasswordsController do
  describe "GET new" do
    #note need not test here because all it is doing is rendering a page
  end

  describe "POST create" do

    context "empty field" do

      it "renders the forgot password page" do
        post :create, email: " "
        expect(response).to render_template "forgot_passwords/new"
      end

      it "displays an error message" do
        post :create, email: " "
        expect(flash[:danger]).to eq("Email field cannot be left blank.")
      end
    end

    context "valid user email" do
      before do
         Fabricate(:user, email: "joe@example.com") 
      end
      it "redirects to the reset password confirmation page" do
        post :create, email: "joe@example.com"
        expect(response).to redirect_to reset_confirmation_path
      end

      it "sends out an email to the email address" do
        post :create, email: "joe@example.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
      end
    end

    context "invalid user email" do
      before do
        Fabricate(:user, email: "doo@example.com")
      end
      it "displays an error message saying that email does not exist" do
        post :create, email: "boo@example.com"
        expect(flash[:danger]).to eq("A user with that email could not be found. Please check your email or register as a user instead.")
      end
      it "renders the forgot password page" do
        post :create, email: "boo@example.com"
        expect(response).to render_template "forgot_passwords/new"
      end
    end
  end
end


















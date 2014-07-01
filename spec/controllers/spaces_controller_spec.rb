require 'rails_helper'

describe SpacesController do
  
  describe "GET Index" do
    it 'should show the spaces arranged by total votes' do
      space1 = Fabricate(:space)
      expect(@spaces).to
    end
  end

  describe 'GET Show' do
    it 'should the space selected'
    it 'should show associated comments'
  end

  describe "POST Create" do
    context "valid submission" do
      it 'should create a new space if the space does not already exist' 
      it 'displays a success message if space can be created'
      it 'redirects the user to the root path'
    end #ends valid context

    context "invalid submission" do
      it 'requires user to be signed in in order to post a space'
      it 'should not create a duplicate space'
      it 'displays the flash error message'
      it 'sets the @user instance variable'
      it 'redirects the user to the add new space page'
    end #ends invalid submission context
  end #ends POST Create

  describe "PUT Update" do
  end

  describe "GET Vote" do
    context "signed in user" do
      it 'only allows a signed in user to vote'
      it 'displays a success message upon successful voting'
      it 'redirects user back to previous page'
    end

    context "unauthenticated user" do
      it 'does not allow a non signed in user to vote'
      it 'redirects user back to the previous page'
      it 'displays a flash error message'
    end
  end
end

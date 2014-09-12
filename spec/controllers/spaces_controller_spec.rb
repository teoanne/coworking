require 'rails_helper'

describe SpacesController do
  
  describe "GET Index" do
    it 'should show the spaces arranged by created at date (desc)' do
      space1 = Fabricate(:space, created_at: 1.week.ago)
      space2 = Fabricate(:space, created_at: 8.days.ago)
      space3 = Fabricate(:space, created_at: 1.month.ago)
      get :index
      expect(assigns(:spaces)).to eq([space1, space2, space3])
    end
  end

  describe "GET show" do

    it 'should show a comment form' do
      space = Fabricate(:space)
      get :show, id: space.id
      expect(assigns(:comment)).to be_instance_of(Comment)
    end
  end

  describe "POST Create" do
    let(:current_user) { Fabricate(:user) } 

    context "valid submission" do
      before do
        set_current_user(current_user)
      end

      it 'should create a new space if the space does not already exist' do
        post :create, user_id: current_user.id, space: Fabricate.attributes_for(:space)
        expect(Space.count).to eq(1)
      end

      it 'displays a success message if space can be created' do
        post :create, user_id: current_user.id, space: Fabricate.attributes_for(:space)
        expect(flash[:notice]).to be_present
      end

      it 'redirects the user to the root path' do
        post :create, user_id: current_user.id, space: Fabricate.attributes_for(:space)
        expect(response).to redirect_to home_path
      end
    end #ends valid context

    context "invalid submission" do

      it_behaves_like "require sign in" do
        let(:action) { post :create, space: Fabricate.attributes_for(:space) } 
      end

      it 'should not create a duplicate space' do
        space1 = Fabricate(:space, name: "Foo")
        set_current_user
        post :create, space: Fabricate.attributes_for(:space, name: "Foo")
        expect(Space.count).to eq(1)
      end

      it 'displays the flash error message' do
        set_current_user
        post :create, space: Fabricate.attributes_for(:space, name: "Foo")
        expect(flash[:danger]).to be_present
      end

      it 'redirects the user to the add new space page' do
        set_current_user
        post :create, space: Fabricate.attributes_for(:space, name: "Foo")
        expect(response).to render_template :new
      end
    end #ends invalid submission context
  end #ends POST Create

  describe "PUT Update" do
  end

  describe "GET Vote" do
    context "signed in user" do

      it_behaves_like "require sign in" do
        let(:action) { put :update, vote: true } 
      end

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

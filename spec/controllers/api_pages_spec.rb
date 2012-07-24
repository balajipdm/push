require 'spec_helper'

describe Api::PagesController do
  describe "list pages" do
    it "should list all on index" do
      pages = (1..3).collect { Factory(:page) }

      get :index, format: :xml
      assigns(:pages).should eq pages
    end

    it "should list unpublished at unpublished" do
      pages = (1..3).collect { Factory(:page, :published_on => nil) }
      Factory(:page, :published_on => 1.day.ago)

      get :unpublished, format: :xml
      assigns(:pages).should eq pages
    end

    it "should list published at published" do
      pages = (1..3).collect { Factory(:page, :published_on => 1.day.ago) }
      Factory(:page, :published_on => nil)

      get :published, format: :xml
      assigns(:pages).should eq pages.reverse
    end

    it "should show" do
      page = Factory(:page)
      get :show, id: page.id, format: :xml
      assigns(:page).should eq page
    end

    it "shows accessible attributes on new" do
      # currently no need to check the attributes
      get :new, format: :xml
    end

    it "can create a page" do
      attributes = Factory.attributes_for(:page)
      post :create, page: attributes

      assigns(:page).should_not eq nil
      assigns(:page).persisted?.should eq true
    end

    it "gets the total words" do
      page = Factory(:page, :title => 'One Two', :content => 'Three Four Five Six')
      get :total_words, page_id: page.id
      # TODO: check response, should eq 6
    end

    it "should publish the page" do
      page = Factory(:page, :published_on => nil)
      post :publish, page_id: page.id
      page.reload
      page.published_on.should_not eq nil
    end

    it "should update the page" do
      page = Factory(:page)

      attributes = Factory.attributes_for(:page)

      post :update, page: attributes, id: page.id
      page.reload

      attributes.each do |attr, value|
        page.send(attr).should eq value
      end
    end

    it "should delete the page" do
      page = Factory(:page)
      delete :destroy, id: page.id
      Page.find_by_id(page.id).should eq nil
    end

  end
end

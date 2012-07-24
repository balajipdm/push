class Api::PagesController < ApplicationController
  
  def index
    @pages = Page.all
    respond_with_pages
  end
  
  def published
    @pages = Page.where(["published_on < ?", Time.now.utc])
    @pages = @pages.order("published_on DESC")
    respond_with_pages
  end
  
  def unpublished
    @pages = Page.where(["published_on is ? or published_on > ?", nil, Time.now.utc])
    @pages = @pages.order("published_on DESC")
    respond_with_pages
  end
  
  def new
    @page = Page.new
    accessible_attributes = Page._accessible_attributes[:default].to_a
    @res = @page.attributes.delete_if do |attr|
      !accessible_attributes.include?(attr)
    end
    respond_to do |format|
      format.json { render json: @page }
      format.xml { render xml: @page }
    end
  end
  
  def create
    @page = Page.new(params[:page])
    respond_to do |format|
      if @page.save
        format.json { render json: @page, status: :created, location: @page }
        format.xml { render xml: @page, status: :created, location: @page }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
        format.xml { render xml: @page.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def total_words
    @page = Page.find(params[:page_id])
    respond_to do |format|
      format.json { render json: {total_words: @page.total_words} }
      format.xml { render xml: {total_words: @page.total_words} }
    end
  end
  
  def publish
    @page = Page.find(params[:page_id])
    respond_to do |format|
      if @page.update_attributes({published_on: Time.now.utc})
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
        format.xml { render xml: @page.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @page = Page.find(params[:id])
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
        format.xml { render xml: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end
  
  private

  def respond_with_pages
    respond_to do |format|
      format.json { render json: @pages }
      format.xml { render xml: @pages }
    end
  end
  
end
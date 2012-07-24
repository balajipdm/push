require 'test_helper'

class PageTest < ActiveSupport::TestCase
  
  def test_should_create_page
    assert_difference 'Page.count' do
      d = create_page
      assert !d.new_record?, "#{d.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_title
    assert_no_difference 'Page.count' do
      a = create_page(:title => nil)
      assert a.errors[:title]
    end
  end
  
  def test_should_require_content
    assert_no_difference 'Page.count' do
      a = create_page(:content => nil)
      assert a.errors[:content]
    end
  end
  
  protected

  def create_page(options = {})
    Page.create({:title => "test Page title", :content => "test page content"}.merge(options))
  end

end

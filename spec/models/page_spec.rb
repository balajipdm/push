require 'spec_helper'

describe Page do
  it "should count words" do
    page = Factory(:page, :title => 'One Two', :content => 'Three Four Five Six One-Word! Another! Yeah.')
    page.total_words.should eq 9
  end

  it "should be published if the time past" do
    page = Factory(:page)

    page.published_on = 1.day.from_now.utc
    page.published.should eq false

    page.published_on = nil
    page.published.should eq false

    page.published_on = 1.day.ago.utc
    page.published.should eq true
  end
end

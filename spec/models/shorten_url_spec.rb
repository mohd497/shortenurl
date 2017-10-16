require 'rails_helper'

RSpec.describe ShortenUrl, type: :model do

  it "should be valid with valid attributes" do
    expect(ShortenUrl.new(url: 'www.test.com')).to be_valid
  end

  it "should not be valid with invalid attributes" do
    expect(ShortenUrl.new(url: 'test')).to_not be_valid
  end

  it "should add url protocol if not provided" do
    shorten_url = FactoryGirl.create(:shorten_url)
    shorten_url.url.should == 'http://www.test.com'
  end

  it "should fetch url" do
    shorten_url = FactoryGirl.create(:shorten_url)
    hash_url = {:url => 'http://www.test.com', :shortened_url=>"example.com/#{shorten_url.unique_key}"}

    expect(ShortenUrl.fetch_with_key(shorten_url.unique_key, 'example.com')).to eq hash_url
  end

  it "should merge base url with key" do
    expect(ShortenUrl.merge_url('test', 'example.com')).to eq 'example.com/test'
  end

end
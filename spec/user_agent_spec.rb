require 'spec_helper'

describe Nunchaku do
  describe "specifying the User-Agent string" do

    it "doesn't specify an user-agent by default" do
      stub_request(:get, "http://validator.w3.org/nu/?doc=http://validationhell.com&out=json").
        to_return(:status => 200, :body => fixture_file('validationhell.response'))

        checker = Nunchaku.check('http://validationhell.com')
        expect(checker.raw).to eq JSON.parse(fixture_file('validationhell.response'))
    end

    it "chrome" do
      stub_request(:get, "http://validator.w3.org/nu/?doc=http://validationhell.com&out=json&useragent=#{escaped chrome}").
        to_return(:status => 200, :body => fixture_file('validationhell.response'))

        checker = Nunchaku.check('http://validationhell.com', user_agent: chrome)
        expect(checker.raw).to eq JSON.parse(fixture_file('validationhell.response'))
    end

    it "firefox" do
      stub_request(:get, "http://validator.w3.org/nu/?doc=http://validationhell.com&out=json&useragent=#{escaped firefox}").
        to_return(:status => 200, :body => fixture_file('validationhell.response'))

        checker = Nunchaku.check('http://validationhell.com', user_agent: firefox)
        expect(checker.raw).to eq JSON.parse(fixture_file('validationhell.response'))
    end

    private

    def escaped(str)
      CGI::escape(str)
    end

    def chrome
      "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
    end

    def firefox
      "Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0"
    end
  end
end

require 'spec_helper'

describe Nunchaku do
  before(:each) do
    stub_request(:get, "https://html5.validator.nu/?doc=http://validationhell.com&out=json").
      to_return(:status => 200, :body => fixture_file('validationhell.response'))
  end

  describe "initialization" do
    it "sets the URL of the document to check" do
      checker = Nunchaku.check('http://validationhell.com')
      expect(checker.url).to eq 'http://validationhell.com'
    end

    it "has a default checker URI" do
      checker = Nunchaku.check('http://validationhell.com')
      expect(checker.checker_uri).to eq 'https://html5.validator.nu/'
    end

    it "checker URI can be set" do
      checker = Nunchaku.check('http://validationhell.com', checker_uri: 'http://checker.example.com/')
      expect(checker.checker_uri).to eq 'http://checker.example.com/'
    end
  end

  describe "checking markup" do
    let(:checker) { Nunchaku.check('http://validationhell.com') }

    it "returns the raw JSON response" do
      expect(checker.raw).to eq JSON.parse(fixture_file('validationhell.response'))
    end

    it "returns the list of messages" do
      expect(checker.messages.size).to eq 12
      expect(checker.messages.first.message).to eq "Obsolete doctype. Expected “<!DOCTYPE html>”."
    end

    it "filters errors from the messages" do
      expect(checker.errors.size).to eq 11
      expect(checker.errors.first.message).to eq "The “align” attribute on the “img” element is obsolete. Use CSS instead."
    end

    it "filters warnings from the messages" do
      expect(checker.warnings.size).to eq 1
      expect(checker.warnings.first.message).to eq "Obsolete doctype. Expected “<!DOCTYPE html>”."
    end
  end
end

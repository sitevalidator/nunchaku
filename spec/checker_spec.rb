require 'spec_helper'

describe Nunchaku::Checker do
  describe "initialization" do
    it "sets the URL of the document to check" do
      checker = Nunchaku::Checker.new('http://validationhell.com')
      expect(checker.url).to eq 'http://validationhell.com'
    end

    it "has a default checker URI" do
      checker = Nunchaku::Checker.new('http://validationhell.com')
      expect(checker.checker_uri).to eq 'https://html5.validator.nu/'
    end

    it "checker URI can be set" do
      checker = Nunchaku::Checker.new('http://validationhell.com', checker_uri: 'http://checker.example.com/')
      expect(checker.checker_uri).to eq 'http://checker.example.com/'
    end
  end

  describe "checking markup" do
    let(:checker) { Nunchaku::Checker.new('http://validationhell.com') }

    it "returns the raw JSON response" do
      expect(checker.raw).to eq expected_json
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

  private

  def expected_json
    {"url"=>"http://validationhell.com", "messages"=>[{"type"=>"info", "lastLine"=>1, "lastColumn"=>109, "firstColumn"=>1, "subType"=>"warning", "message"=>"Obsolete doctype. Expected “<!DOCTYPE html>”.", "extract"=>"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html", "hiliteStart"=>0, "hiliteLength"=>109}, {"type"=>"error", "lastLine"=>56, "firstLine"=>55, "lastColumn"=>64, "firstColumn"=>37, "message"=>"The “align” attribute on the “img” element is obsolete. Use CSS instead.", "extract"=>" href=\"/\"><img\n src=\"/images/fire.png\" align=\"absmiddle\" width=\"30\" hspace=\"5\"><stron", "hiliteStart"=>10, "hiliteLength"=>69}, {"type"=>"error", "lastLine"=>56, "firstLine"=>55, "lastColumn"=>64, "firstColumn"=>37, "message"=>"The “hspace” attribute on the “img” element is obsolete. Use CSS instead.", "extract"=>" href=\"/\"><img\n src=\"/images/fire.png\" align=\"absmiddle\" width=\"30\" hspace=\"5\"><stron", "hiliteStart"=>10, "hiliteLength"=>69}, {"type"=>"error", "lastLine"=>56, "firstLine"=>55, "lastColumn"=>64, "firstColumn"=>37, "message"=>"An “img” element must have an “alt” attribute, except under certain conditions. For details, consult guidance on providing text alternatives for images.", "extract"=>" href=\"/\"><img\n src=\"/images/fire.png\" align=\"absmiddle\" width=\"30\" hspace=\"5\"><stron", "hiliteStart"=>10, "hiliteLength"=>69}, {"type"=>"error", "lastLine"=>73, "lastColumn"=>67, "firstColumn"=>64, "message"=>"Stray end tag “a”.", "extract"=>"idates</a></a></li>\n", "hiliteStart"=>10, "hiliteLength"=>4}, {"type"=>"error", "lastLine"=>83, "lastColumn"=>66, "firstColumn"=>62, "message"=>"End tag “li” seen, but there were open elements.", "extract"=>"e Abyss...</li>\n     ", "hiliteStart"=>10, "hiliteLength"=>5}, {"type"=>"error", "lastLine"=>83, "lastColumn"=>43, "firstColumn"=>19, "message"=>"Unclosed element “a”.", "extract"=>"      <li><a href=\"/pages/abyss/1\">Enter ", "hiliteStart"=>10, "hiliteLength"=>25}, {"type"=>"error", "lastLine"=>84, "firstLine"=>83, "lastColumn"=>12, "firstColumn"=>67, "message"=>"Element “a” not allowed as child of element “ul” in this context. (Suppressing further errors from this subtree.)", "extract"=>"ss...</li>\n            </ul>\n", "hiliteStart"=>10, "hiliteLength"=>13}, {"type"=>"error", "lastLine"=>84, "lastColumn"=>17, "firstColumn"=>13, "message"=>"End tag “ul” seen, but there were open elements.", "extract"=>"          </ul>\n\n    ", "hiliteStart"=>10, "hiliteLength"=>5}, {"type"=>"error", "lastLine"=>87, "lastColumn"=>161, "firstColumn"=>15, "message"=>"An “a” start tag seen but an element of the same type was already open.", "extract"=>"          <a href=\"https://twitter.com/share\" class=\"twitter-share-button\" data-url=\"http://validationhell.com\" data-via=\"SiteValidator\" data-hashtags=\"w3c\">Tweet<", "hiliteStart"=>10, "hiliteLength"=>147}, {"type"=>"error", "lastLine"=>87, "lastColumn"=>161, "firstColumn"=>15, "message"=>"End tag “a” violates nesting rules.", "extract"=>"          <a href=\"https://twitter.com/share\" class=\"twitter-share-button\" data-url=\"http://validationhell.com\" data-via=\"SiteValidator\" data-hashtags=\"w3c\">Tweet<", "hiliteStart"=>10, "hiliteLength"=>147}, {"type"=>"error", "lastLine"=>87, "lastColumn"=>161, "firstColumn"=>15, "subType"=>"fatal", "message"=>"Cannot recover after last error. Any further errors will be ignored.", "extract"=>"          <a href=\"https://twitter.com/share\" class=\"twitter-share-button\" data-url=\"http://validationhell.com\" data-via=\"SiteValidator\" data-hashtags=\"w3c\">Tweet<", "hiliteStart"=>10, "hiliteLength"=>147}]}
  end

end

require_relative '../lib/onthisday'
require 'minitest/autorun'
require 'webmock/minitest'

require 'webmock'

class TestOnThisDay < MiniTest::Unit::TestCase
  def fixture_file
    fn = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', 'main_page_20120620.html'))
    File.open(fn, "rb").read
  end

  def setup
    @on_this_day = OnThisDay::Parser.new
    stub_request(:get, "en.wikipedia.org/wiki/Main_Page").
      to_return({:body => fixture_file})

  end

  def test_returns_correct_number_of_items
    assert_equal 5, @on_this_day.items.size
  end

  def test_returns_text_of_news_headline
    assert_equal "French Revolution: Meeting on a tennis court near the Palace of Versailles, members of France's Third Estate took the Tennis Court Oath, pledging not to separate until a new constitution was established.", @on_this_day.items[0].text
  end

  def test_returns_html_of_news_headline
    assert_equal "<a href=\"/wiki/French_Revolution\" title=\"French Revolution\">French Revolution</a>: Meeting on a tennis court near the <a href=\"/wiki/Palace_of_Versailles\" title=\"Palace of Versailles\">Palace of Versailles</a>, members of France's <a href=\"/wiki/Estates_of_the_realm\" title=\"Estates of the realm\">Third Estate</a> took the <b><a href=\"/wiki/Tennis_Court_Oath\" title=\"Tennis Court Oath\">Tennis Court Oath</a></b>, pledging not to separate until a new <a href=\"/wiki/Constitution\" title=\"Constitution\">constitution</a> was established.", @on_this_day.items[0].html
  end

  def test_returns_year_of_item
    assert_equal "1789", @on_this_day.items[0].year
  end

  def test_returns_topics_contained_in_news_headline
    item = @on_this_day.items[0]

    ['French_Revolution', 'Palace_of_Versailles', 'Estates_of_the_realm', 'Tennis_Court_Oath', 'Constitution'].each do |topic|
      assert item.topics.include? topic
    end
  end

  def test_three_digit_year_parsed_correctly
    fn = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', 'main_page_20120903.html'))
    fixture = File.open(fn, "rb").read

    on_this_day = OnThisDay::Parser.new
    stub_request(:get, "en.wikipedia.org/wiki/Main_Page").
      to_return({:body => fixture})

    assert_equal "590", on_this_day.items[0].year
  end

  def test_bc_date_parsed_correctly
    fn = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', 'main_page_20120913.html'))
    fixture = File.open(fn, "rb").read

    on_this_day = OnThisDay::Parser.new
    stub_request(:get, "en.wikipedia.org/wiki/Main_Page").
      to_return({:body => fixture})

    assert_equal "509 BC", on_this_day.items[0].year
  end
end

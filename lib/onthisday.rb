# encoding: utf-8

require 'rest_client'
require 'nokogiri'

module OnThisDay
  class Item
    def initialize(element)
      @element = element
      @year = nil
      remove_noprint_elements!
      set_and_remove_year!
    end

    # Remove any child nodes with class "nopront". This removes the
    # boilerplate Wikinews, Obituries etc.
    def remove_noprint_elements!
      @element.xpath('//*[starts-with(@class,"noprint")]').each do |node|
        node.children.remove
      end
    end

    def year
      @year.to_i
    end

    def set_and_remove_year!
      @element.xpath('./a').each do |node|
        title = node['title']

        # if the title of the link looks like a year, e.g. "1879", set
        # the year of this item and remove the node
        if title.match /\A\d{3,4}\z/
          @year = title
          node.remove
        end
      end
    end

    def text
      @element.inner_text.gsub(' – ','')
    end

    def html
      @element.inner_html.gsub(' – ','')
    end

    # Rescursively search for all a elements in this element and
    # return their value (removing /wiki/)
    def topics
      @element.xpath('.//a').map do |a|
        a.attr('href').gsub('/wiki/','')
      end
    end
  end

  class Parser
    def initialize
    end

    def items
      elements = doc.xpath("//div[@id='mp-otd']/ul/li")
      elements.map {|e| Item.new(e)}
    end

    def doc
      Nokogiri::HTML(content)
    end

    def wikipedia_url
      "http://en.wikipedia.org/wiki/Main_Page"
    end

    def content
      RestClient.proxy = ENV['http_proxy']
      @content ||= RestClient.get wikipedia_url
    end
  end
end

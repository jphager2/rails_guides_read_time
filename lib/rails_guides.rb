require 'open-uri'
require 'nokogiri'
require 'singleton'
require 'uri'

require_relative 'read_calculator'

class RailsGuides
  include Singleton
  include Enumerable

  INDEX_URL = 'http://guides.rubyonrails.org/'

  def total_read_time
    total = inject(0) do |count, guide|
      count + ReadCalculator.read_minutes(guide)
    end

    hours = total / 60
    minutes = total % 60
    
    "#{hours} hours, #{minutes} minutes"
  end

  def each(&block)
    enum = links.to_enum.lazy.map { |link| guide_text(link) }
    if block_given?
      enum.each(&block)
    else
      enum
    end
  end

  def links
    return @links if defined?(@links)

    @links = index_doc.css('#mainCol dt a').map do |link|
      absolute_url(link[:href])
    end
  end

  private

  def guide_text(url)
    @cached_guide_text ||= Hash.new do |cache, new_url|
      doc = doc_for(new_url)
      text = doc.css('#mainCol').text.strip.gsub(/\s+/, ' ')
      cache[new_url] = text
    end

    @cached_guide_text[url] 
  end

  def index_doc
    @index_doc ||= doc_for(INDEX_URL)
  end

  def absolute_url(path)
    uri = URI(INDEX_URL)
    path = '/' + path unless path.start_with?('/')
    uri.path = path
    uri.to_s
  end

  def doc_for(url)
    Nokogiri::HTML(open(url).read)
  end
end

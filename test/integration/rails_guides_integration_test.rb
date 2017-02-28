require_relative '../test_helper'

require 'rails_guides'

class RailsGuidesIntegrationTest < MiniTest::Test

  attr_reader :guides

  def setup
    @guides = RailsGuides.instance
  end

  def test_links_length
    assert_equal 49, guides.links.length
  end

  def test_links
    link = URI(guides.links.first)
    assert_equal 'guides.rubyonrails.org', link.host 
  end

  def test_each
    assert_kind_of Enumerator, guides.each
  end
  def test_each_enumerates_guide_text
    beginning_text = "1 Guide AssumptionsThis guide is designed for beginners who want to get started with a Rails application from scratch."
    assert_equal beginning_text, guides.first[0...beginning_text.length]
  end

  def test_total_read_count
    assert_equal '14 hours, 25 minutes', guides.total_read_time
  end
end

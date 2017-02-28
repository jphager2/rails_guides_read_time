require_relative '../test_helper'

require 'read_calculator'

class ReadCalculatorTest < MiniTest::Test

  attr_reader :doc

  def setup
    @doc = %(one two three four five six seven eight nine ten)
  end

  def test_read_minutes
    five_min_doc = Array.new(28 * 5, doc).join(' ')
    assert_equal 5, ReadCalculator.read_minutes(five_min_doc)
  end
end

module ReadCalculator
  extend self

  def read_minutes(doc)
    doc.scan(/\w+/).length / 275
  end
end

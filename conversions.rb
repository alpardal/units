require_relative 'utils/graph'

class Conversions

  def initialize
    @conversion_graph = Utils::Graph.new
  end

  def add_conversion(from, to, factor)
    unless can_convert?(from, to)
      @conversion_graph.connect(from, to, factor.to_f)
      @conversion_graph.connect(to, from, 1.0/factor)
    end
    self
  end

  def can_convert?(from, to)
    @conversion_graph.connected?(from, to)
  end

  def convert(from, to, amount)
    # searches the graph twice: once in `can_convert?`, once in `find_conversion_factor`
    # since in the example the graph is super small, it's not a problem,
    # but in larger graphs you could cache results.
    if can_convert?(from, to)
      factor = find_conversion_factor(from, to)
      amount * factor
    else
      raise "Don't know how to convert from #{from} to #{to}"
    end
  end

private

  def find_conversion_factor(from, to)
    path = @conversion_graph.path(from, to)
    path.map(&:last).inject(1, &:*)
  end
end

require 'set'

module Utils
  class Graph

    def initialize
      @nodes = {}
    end

    def connect(a, b, cost)
      node(a).connect_to(node(b), cost)
      self
    end

    def connected?(a, b)
      !path(a, b).empty?
    end

    # simple breadth-first search
    def path(from, to)
      start, goal = node(from), node(to)

      visited = Set.new
      to_visit = [start]
      parents_and_costs = {}

      until to_visit.empty?
        current = to_visit.shift
        visited << current
        neighbors = current.each_edge.reject {|node, cost| visited.include?(node) }

        neighbors.each do |node, cost|
          parents_and_costs[node.name] = [current.name, cost]

          if node == goal
            return make_path(goal.name, parents_and_costs)
          end

          to_visit << node
        end
      end

      []
    end

  private

    def node(name)
      @nodes[name] ||= Node.new(name)
    end

    def make_path(node, parents_and_costs)
      current = node
      path = [[current, 1]]
      while parents_and_costs[current]
        parent, cost = parents_and_costs[current]
        path << [parent, cost]
        current = parent
      end
      path.reverse
    end

    class Node
      attr_reader :name

      def initialize(name)
        @name = name
        @edges = {}
      end

      def connect_to(node, cost)
        unless connected_to?(node)
          @edges[node] = cost
        end
      end

      def connected_to?(node)
        @edges.key?(node)
      end

      def each_edge(&block)
        @edges.each(&block)
      end
    end
  end
end



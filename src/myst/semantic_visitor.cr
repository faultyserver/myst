require "./semantic/*"
require "./semantic/nodes/*"

module Myst
  class SemanticVisitor
    property  output : IO
    property  errput : IO
    property? capture_failures : Bool

    def initialize(@output : IO = STDOUT, @errput : IO = STDERR, @capture_failures=false)
    end

    def visit(node : Node)
      # Not all nodes need semantic analysis beyond what the parser provides.
      # To ensure that all nodes are visited, though, the default behavior
      # is to call `accept_children` on the node, which will recurse the
      # visitor through any node properties of the current node.
      node.accept_children(self)
    end

    # `warn` will emit a semantic warning to the console, but allow analysis
    # to continue.
    def warn(message : String)
      @errput.puts(message)
    end

    # `fail` emits a semantic error to the console, then immediately halts
    # analysis.
    def fail(message : String)
      warn(message)
      unless capture_failures?
        raise SemanticError.new
      end
    end
  end
end

require "./nodes.cr"

def analyze(node : Node, visitor = Semantic::Visitor.new, mock_output = true, capture_failures = false)
  if mock_output
    visitor.output = IO::Memory.new
    visitor.errput = IO::Memory.new
  end

  visitor.capture_failures = capture_failures

  visitor.visit(node)
  visitor
end

def analyze(node : String, visitor = Semantic::Visitor.new, mock_output = true, capture_failures = false)
  program = parse_program(node)
  analyze(program, visitor, mock_output: mock_output, capture_failures: capture_failures)
end


def expect_semantic_failure(source : String, failure_message : String | Regex)
  error = expect_raises Semantic::Error do
    analyze(source)
  end

  (error.message || "").downcase.should match(failure_message)
end

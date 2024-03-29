require 'rspec/core/formatters/base_text_formatter'
 
class MarkdownFormatter < RSpec::Core::Formatters::BaseTextFormatter
 
  def initialize(output)
    super(output)
    @group_level = 0
  end
 
  def example_group_started(example_group)
    super(example_group)
 
    output.puts if @group_level == 0
    output.puts "#{current_markup}#{escape_markdown(example_group.description)}"
 
    @group_level += 1
  end
 
  def example_group_finished(example_group)
    @group_level -= 1
  end
 
  def example_passed(example)
    super(example)
    output.puts passed_output(example)
  end
 
  def example_pending(example)
    super(example)
    output.puts pending_output(example, example.execution_result[:pending_message])
  end
 
  def example_failed(example)
    super(example)
    output.puts failure_output(example, example.execution_result[:exception])
  end
 
  def failure_output(example, exception)
    "#{current_markup}#{escape_markdown(example.description)} (FAILED - #{next_failure_index})"
  end
 
  def next_failure_index
    @next_failure_index ||= 0
    @next_failure_index += 1
  end
 
  def passed_output(example)
    "#{current_markup}#{escape_markdown(example.description)}"
  end
 
  def pending_output(example, message)
    "#{current_markup}#{escape_markdown(example.description)} (PENDING: #{message})"
  end
 
  def current_markup
    spaces = '  ' * @group_level
    markup_element = @group_level == 0 ? '### ' : '- '
    spaces + markup_element
  end
 
  def example_group_chain
    example_group.ancestors.reverse
  end
 
  def escape_markdown(input)
    input.gsub(/([#_])/,'\\\\\1')
  end
 
end
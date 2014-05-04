require_relative 'rule'
require_relative 'printers'

class ElementaryAutomata
  def initialize(options={})
    @state   = options[:seed] || '0'*50+'1'+'0'*50
    @rule    = options[:rule] || Rule.new(126)
    @printer = options[:printer] || TerminalPrinter.new
  end

  def start(n=500)
    @printer.print(@state)
    n.times { step }
  end

  private
    def step
      apply_rules
      @state = @next_state
      @printer.print(@state)
    end

    def apply_rules
      @next_state = @state.dup
      (1...@state.length-1).to_a.each do |i|
        triple = @state[i-1, 3]
        @next_state[i] = @rule.apply(triple)
      end
      apply_cylindrical_boundary_condition
    end

    def apply_cylindrical_boundary_condition
      left_triple = @state[-1] + @state[0, 2]
      @next_state[0] = @rule.apply(left_triple)
      right_triple = @state[-2, 2] + @state[0]
      @next_state[-1] = @rule.apply(right_triple)
    end
end

auto = ElementaryAutomata.new
auto.start
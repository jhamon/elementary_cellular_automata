require_relative 'rule'
require_relative 'printers'

class ElementaryAutomata
  DEFAULT_SEED = '000000000000000010000000000000000'

  def initialize(options={})
    @state   = options[:seed] || DEFAULT_SEED
    @rule    = options[:rule] || Rule.new(73)
    @printer = options[:printer] || TerminalPrinter.new
    @printer.print(@state)
  end

  def run(n=@seed.length)
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
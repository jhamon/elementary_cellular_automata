require_relative 'rule'
require_relative 'printers'

class ElementaryAutomata
  def initialize(options={})
    @state   = options[:seed] || ['0']*40+['1']+['0']*40
    @rule    = options[:rule] || Rule.new(126)
    @printer = options[:printer] || TerminalPrinter.new
  end

  def start(n=50)
    @printer.print(@state)
    n.times { self.step }
  end

  def step
    apply_rules
    @state = @next_state
    @printer.print(@state)
  end

  def apply_rules
    @next_state = @state.dup
    (1...@state.length-2).to_a.each do |i|
      triple = @state[i-1, 3].join('')
      @next_state[i] = @rule.apply(triple)
    end
  end
end

auto = ElementaryAutomata.new
auto.start
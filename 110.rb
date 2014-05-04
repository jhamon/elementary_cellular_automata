class OneTen
  DIE = ['111', '100', '000']

  def initialize(seed=nil, printer=TerminalPrinter.new)
    @state = seed || ['1']*80
    @printer = printer
  end

  def start(n=1000)
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
      three = @state[i-1, 3].join('')
      @next_state[i] = DIE.include?(three) ? '0' : '1'
    end
  end
end

class TerminalPrinter
  SYMBOLS = {'0' => ' ', '1' => '█'}

  def print(data_array)
    puts data_array.map { |sym| SYMBOLS[sym] }.join('')
  end
end

oneten = OneTen.new()
oneten.start
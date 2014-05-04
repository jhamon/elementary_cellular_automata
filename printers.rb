class TerminalPrinter
  SYMBOLS = {'0' => ' ', '1' => '█'}

  def print(data_array)
    puts data_array.split('').map { |sym| SYMBOLS[sym] }.join('')
  end
end
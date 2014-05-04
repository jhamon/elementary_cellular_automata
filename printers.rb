require 'chunky_png'
require 'pry'

class TerminalPrinter
  SYMBOLS = {'0' => ' ', '1' => '█'}

  def print(data_str)
    puts data_str.split('').map { |sym| SYMBOLS[sym] }.join('')
  end
end

class PNGPrinter
  attr_accessor :filename

  COLORS = {
    '1' => ChunkyPNG::Color.rgb(0,0,0), 
    '0' => ChunkyPNG::Color.rgb(255,255,255)
  }

  def initialize
    @filename = 'automata.png'
    @data = []
  end

  def print(data_str)
    colors = data_str.split('').map { |bit| COLORS[bit] }
    @data << colors
  end

  def save
    width = @data[0].length
    height = @data.length
    @file = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::BLACK)
    @data.each_with_index do |row, r|
      row.each_with_index do |col, c|
        @file[c, r] = col
      end
    end
    @file[1,1] = ChunkyPNG::Color.rgba(10, 20, 30, 128)
    @file.save(@filename, :interlace => true)
  end
end
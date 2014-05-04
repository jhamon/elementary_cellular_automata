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
    create_image
    write_data
    @image.save(@filename, :interlace => true)
    puts "Data written to #{@filename}"
  end

  private
    def write_data
      @data.each_with_index do |row, r|
        row.each_with_index do |col, c|
          @image[c, r] = col
        end
      end
    end

    def create_image
      width = @data[0].length
      height = @data.length
      @image = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::BLACK)
    end
end
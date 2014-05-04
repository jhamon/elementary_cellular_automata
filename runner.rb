require_relative 'elementary_automata'

def show_help
  help = <<-HELPDOC
    This runner is to help you easily create images of elementary 
    automata using the standard starting condition of a single 
    centered living pixel.

    On the command line, run this program with arguments specifying 
    the desired rule number and output image width and height in 
    pixels.  

    For example, try running the following (without the $):
    
      $ ruby runner.rb 73 800 600

    This will run an 800 pixel wide simulation using Rule 73 For 600 
    timesteps and save the output as a 800x600 PNG image named 73.png.

    For customized starting conditions, you will need to write your
    own scripts passing a :seed option to the ElementaryAutomata 
    class.

    See http://mathworld.wolfram.com/ElementaryCellularAutomaton.html
    for more information about the output of this program.
  HELPDOC
  puts help
  exit(0)
end

def make_centered_pixel_seed(width)
  seed = '0'*width
  seed[width/2] = '1'
  seed
end

if ARGV.length < 3
  show_help
else
  ARGV.map!(&:to_i)
  rule             = Rule.new(ARGV[0])
  printer          = PNGPrinter.new
  printer.filename = "#{ARGV[0]}.png"
  steps            = ARGV[2]
  seed             = make_centered_pixel_seed(ARGV[1])

  auto = ElementaryAutomata.new(:printer => printer, 
                                :seed => seed, 
                                :rule => rule)
  auto.run(steps)
  printer.save
end
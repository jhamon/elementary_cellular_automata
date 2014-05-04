# Elementary Cellular Automata

Elementary Cellular Automata (ECA) are the simplest type of cellular automaton.  ECAs operate in 1 dimension only.  The system state is represented by a list of bits which are updated once per iteration based on rules you specify.  In visual representations of ECAs, time is usually shown by appending the current state of an ECA to the bottom of the previous output.

## Rules

In every iteration, a cell may live or die depending on its value and the value of its two neighbors.  
A cell and its neighbors can be in any of eight different configurations.  A rule governs what value these states map to in the next generation, and there are `2**8=256` possible rules although many combinations of rules produce indistinguishable results from one another.

As a convenience, rule names are expressed as the decimal representation of the output rules interpreted as a binary number. For example, the following rule would be referred to as "Rule 73" because the binary number `01001001` is the decimal number 73:
  

| current state of cell and neighbors | cell's state in next generation |
|:-----------------------------------:|:--------------------------------|
|  `111`                              | `0`                             |
|  `110`                              | `1`                             |
|  `101`                              | `0`                             |
|  `100`                              | `0`                             |
|  `011`                              | `1`                             |
|  `010`                              | `0`                             |
|  `001`                              | `0`                             |
|  `000`                              | `1`                             |

## Setup / Dependencies

This project relies on the [`chunky_png`](https://github.com/wvanbergen/chunky_png) gem to save simulation outputs as images.  Before running any other commands, make sure you have this gem installed by running `bundle install` from the project root.

## Seeing canned simulation output

The most conventional seed state is a single centered living pixel.  If you just want to see some different outputs using this standard starting condition, you can use the `runner.rb` command line tool to easily generate output images for a given rule and output image size.  The syntax is `ruby runner.rb [rule number] [output_image_width] [output_image_height]`.  For example,

```
$ ruby runner.rb 182 1440 900
Data written to 182.png
```

This would create a game 1440 pixels wide game using Rule 182 and run it for 900 generations before saving the output to a desktop-wallpaper sized 1440x900 pixel png file called `182.png`.  The example output images were all created with this tool, but at a more modest output size.

## Seeding the simulation for custom output

The only way we can influence the output is in our rule selection and selection of seed state.  You can easily run the simulation with a custom seed by passing one in the options hash when instantiating a new automaton.  

```ruby
seed = '10101000001100001100000111' # or whatever
rule = Rule.new(30)
automaton = ElementaryAutomata.new(:seed => seed, 
                                   :rule => rule)
automaton.run(300) # Run for 300 generations
```

By default `ElementaryAutomata` will print output to STDOUT with a `TerminalPrinter` instance, but if you'd like to save output as images you should also pass an instance of `PNGPrinter` to the automaton and call `save` on it after the simulation is finished.

```ruby
seed    = '10101000001100001100000111' # or whatever
rule    = Rule.new(30)
printer = PNGPrinter.new

automaton = ElementaryAutomata.new(:seed => seed, 
                                   :rule => rule,
                                   :printer => printer)

automaton.run(300) # Run for 300 generations

printer.filename = "Rule30_eca_custom_seed.png"
printer.save       # Writes your data to image file.
```

## Example Gallery

#### **Rule 30** 
![Rule 30](/example_output/30.png)

#### **Rule 73** 
![Rule 73](/example_output/73.png)

#### **Rule 90** 
![Rule 90](/example_output/90.png)

#### **Rule 94** 
![Rule 94](/example_output/94.png)

#### **Rule 110** 
![Rule 110](/example_output/110.png)

#### **Rule 150** 
![Rule 150](/example_output/150.png)

#### **Rule 158** 
![Rule 158](/example_output/158.png)

#### **Rule 182** 
![Rule 182](/example_output/182.png)

#### **Rule 188** 
![Rule 188](/example_output/188.png)

#### **Rule 190** 
![Rule 190](/example_output/190.png)

#### **Rule 220** 
![Rule 220](/example_output/220.png)

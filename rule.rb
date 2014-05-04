class InvalidRuleError < StandardError
  # Raised when trying to create a rule outside
  # the valid range of (0..255).
end

class Rule
  def initialize(rule_number)
    valid_rule?(rule_number)
    parse_rule_number(rule_number)
    build_rules_hash
  end

  def apply(triple)
    @rules[triple]
  end

  private
    def valid_rule?(rule_number)
      raise InvalidRuleError if !(0..255).to_a.include?(rule_number)
    end

    def parse_rule_number(rule_number)
      @settings = rule_number.to_s(2)
                             .rjust(8, '0')
                             .split('')
    end

    def build_rules_hash
      @rules = {}
      (0...8).to_a.reverse.each_with_index do |rule_num, i|
        rule_string = rule_num.to_s(2).rjust(3, '0')
        @rules[rule_string] = @settings[i]
      end
    end
end

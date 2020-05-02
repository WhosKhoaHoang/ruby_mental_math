class Problem
  attr_reader :expr, :ans

  def initialize
    @expr = gen_expr
    @ans = eval @expr
  end

  private
  def gen_expr
    # Consider: Generalization of the
    #           number of operands
    operand1 = rand(10)
    operand2 = rand(10)
    operator = ["+", "-", "/"].sample
    if operator == "/"
      while operand2 == 0
        operand2 = rand(10)
      end
      while operand1 % operand2 != 0
        operand1 = rand(10)
      end
    end

    return operand1.to_s+operator+operand2.to_s
  end

end

class Problem
  attr_reader :expr, :ans

  def initialize
    @expr = gen_expr
    @ans = eval @expr
  end

  private
  def gen_expr
    operand1 = rand(10)
    operand2 = rand(10)
    # TODO: make a special case for divison
    #       where only problems associated with
    #       a whole number answer is generated
    operator = ["+", "-", "/"].sample
    return operand1.to_s+operator+operand2.to_s
  end

end

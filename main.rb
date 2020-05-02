require_relative "problem"

# TODO: Save best times to a local txt file
#       - Be sure to string format the times properly
num_probs = 0
PROB_LIM = 5  # Hard-code this for now
while num_probs < PROB_LIM
  prob = Problem.new
  puts prob.expr
  user_ans = gets.to_f
  if user_ans == prob.ans
    puts "GOOD JOB"
  else
    puts "WRONG. The correct answer was %d" % [prob.ans]
  end
   num_probs+=1
end

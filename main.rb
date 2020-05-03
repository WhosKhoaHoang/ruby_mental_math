require "time"
require_relative "utils"
require_relative "problem"

# TODO: Unhardcode PROB_LIM

num_probs = 0
PROB_LIM = 5  # Hard-code this for now


# Use Process, not Time.now. Reference:
# https://blog.dnsimple.com/2018/03/elapsed-time-with-ruby-the-right-way/
t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
while num_probs < PROB_LIM
  prob = Problem.new
  puts prob.expr
  user_ans = gets.to_f
  # TODO: Beware how pressing enter when the answer is 0
  #       will cause user_ans == prob.ans to be true...
  if user_ans == prob.ans
    puts "GOOD JOB"
  else
    puts "WRONG. The correct answer was %d" % [prob.ans]
  end
   num_probs+=1
end
t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
t_elapsed = Time.at(t2-t1).utc.strftime("%H:%M:%S.%2N")
puts t_elapsed


# TODO: Factor in how many problems the user got
#       correct into the scores placement
if File.exists? "scores.txt"
  scores_content = Utils.process_scores(t_elapsed)
  File.write("scores.txt", scores_content, mode: "w")
else
  File.open("scores.txt", "w") { |f| f.write "1. #{t_elapsed}" }
end

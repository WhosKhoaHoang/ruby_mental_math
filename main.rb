require_relative "problem"

# TODO:
# . Save top 3 times to a local txt file
# . Unhardcode PROB_LIM

num_probs = 0
PROB_LIM = 5  # Hard-code this for now

# Use Process, not Time.now. Reference:
# https://blog.dnsimple.com/2018/03/elapsed-time-with-ruby-the-right-way/
t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
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
t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = Time.at(t2-t1).utc.strftime("%H:%M:%S.%2N")
puts elapsed

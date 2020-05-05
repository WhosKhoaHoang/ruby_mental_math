require "time"
require_relative "utils"
require_relative "problem"

# TODO: Unhardcode prob_lim
prob_lim = 5  # Hard-code this for now
results = Utils.problem_loop(prob_lim)
t_elapsed = results[:t_elapsed]
score = results[:score]
puts "\n===== RESULTS ====="
puts t_elapsed
puts score

if File.exists? "scores.txt"
  scores_content = Utils.process_results(t_elapsed, score)
  File.write("scores.txt", scores_content, mode: "w")
else
  File.open("scores.txt", "w") { |f| f.write "1. #{t_elapsed}, #{score}" }
end

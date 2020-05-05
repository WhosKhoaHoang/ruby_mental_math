require_relative "problem"

# PROTIP: Think of a module as a specific kind of
#         class that only has static methods/variables
module Utils
  # This module contains helper methods
  # for a mental math program.

  def self.evaluate_entry(entry)
    # Evaluates an entry to be inserted in the scores
    # file based on the entry's completion time and score.
    # @param entry: The entry to evaluate
    # return: A score for the provided entry
    # rtype: float

    time_w = 1
    score_w = 20
    # . Entries would be sorted in ascending order.
    #   Here is what would contribute to a good score:
    #   - For entry[0], smaller time
    #   - For entry[1], larger negative quotient
    return Time.parse(entry[0]).to_f*time_w +
           (-entry[1].to_r.to_f)*score_w
  end


  def self.format_entry(rank, info)
    # Returns a formatted string containing the
    # information for an entry scores file.
    # @param rank: A 0-based rank of an entry
    # @param info: An array containing information
    #              for an entry where the 0th element
    #              is the time and the 1st element is the score
    # return: A formatted string containing the information
    #         for an entry scores file
    # rtype: String
    return "#{rank+1}. #{info[0]}, #{info[1]}"
  end


  def self.gen_scores_content(entries)
    # Generates the string to be written to a scores file.
    # @param entries: An array containing the entries
    #                 to be written in a scores file
    # type entries: Array
    # return: A string to be written to a scores file
    # rtype: Array
    return entries.each_with_index
                  .map{ |e, i| self.format_entry(i, e)}
                  .join("\n")
  end


  def self.parse_entries(content)
    # Parses the entries in a scores file.
    # @param content: The string contents of a scores file
    # type contet: String
    # return: An array of a score file's parsed contents
    #         to allow for easier processing.
    # rtype: [Array]
    result = []
    content.each do |line|
      entry = line.split(". ")[1]
      comps = entry.split(", ")
      result.append([comps[0].strip, comps[1].strip])
    end

    return result
  end


  def self.problem_loop(prob_lim)
    # Runs a loop that repeatedly gives problems
    # to the user a num_probs number of times.
    # @param prob_lim: The number of problems
    #                   to give to the user
    # type prob_lim: int
    # return: A Hash with keys :t_elapsed
    #         and :score
    # rtype: Hash
    num_probs = 0
    num_correct = 0
    # Use Process.clock_gettime, not Time.now. Reference:
    # https://blog.dnsimple.com/2018/03/elapsed-time-with-ruby-the-right-way/
    t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    while num_probs < prob_lim
      prob = Problem.new
      puts prob.expr
      user_ans = gets.to_f
      # TODO: Beware how pressing enter when the answer is 0
      #       will cause user_ans == prob.ans to be true...
      if user_ans == prob.ans
        puts "GOOD JOB"
        num_correct+=1
      else
        puts "WRONG. The correct answer was %d" % [prob.ans]
      end
       num_probs+=1
    end
    t2 = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    return {
            :t_elapsed=>Time.at(t2-t1).utc.strftime("%H:%M:%S.%2N"),
            :score=>num_correct.to_s+"/"+prob_lim.to_s
           }
  end


  def self.process_results(t_elapsed, score)
    # Processes the results of a mental math session.
    # @param t_elapsed: The time taken for the mental
    #                   math session.
    # @param score: The score achieved from the mental
    #               math session (# correct/total)
    # type t_elpased: String
    # type score: String
    # return: A string to be written to a scores file
    # rtype: String
    content = File.read("scores.txt").split("\n")
    entries = self.parse_entries(content)
    entries.append([t_elapsed, score])

    entries = entries.sort_by{ |e| self.evaluate_entry(e) }
    entries = entries.slice(0, 3) if entries.length > 3

    return self.gen_scores_content(entries)
  end

end

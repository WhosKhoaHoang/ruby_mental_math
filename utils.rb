# PROTIP: Think of a module as a specific kind of
#         class that only has static methods/variables
module Utils

  def self.process_scores(t_elapsed, score)
    content = File.read("scores.txt").split("\n")
    entries = self.parse_entries(content)
    entries.append([t_elapsed, score])

    entries = entries.sort_by{ |e| self.evaluate_entry(e) }
    entries = entries.slice(0, 3) if entries.length > 3

    return self.gen_scores_content(entries)
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


  def self.format_entry(rank, info)
    # Returns a formatted string containing the information
    # for an entry scores file
    # @param rank: A 0-based rank of an entry
    # @param info: An array containing information
    #              for an entry where the 0th element
    #              is the time and the 1st element is the score
    # return: A formatted string containing the information
    #         for an entry scores file
    # rtype: String
    return "#{rank+1}. #{info[0]}, #{info[1]}"
  end


  def self.evaluate_entry(entry)
    # Evaluates an entry to be inserted in the scores
    # file based on the entry's completion time and score
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

end

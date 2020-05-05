# PROTIP: Think of a module as a specific kind of
#         class that only has static methods/variables
module Utils

  def self.process_scores(t_elapsed, score)
    content = File.read("scores.txt").split("\n")
    entries = self.parse_entries(content)
    entries.append([t_elapsed, score])

    # TODO: Come up with way to evaluate time and score together?
    entries = entries.sort_by{ |e| [Time.parse(e[0]), -e[1].to_r]}
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
    return "#{rank+1}. #{info[0]}, #{info[1].to_r.to_s}"
  end
end

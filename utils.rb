module Utils
  def self.process_scores(t_elapsed)
    content = File.read("scores.txt").split("\n")
    times = content.map{ |l| Time.parse(l.split(". ")[1]) }
    times.append(Time.parse(t_elapsed))
    times = times.sort
    if times.length > 3
      times = times.slice(0, 3)
    end

    outfile = times.each_with_index
                   .map{ |t, i| "#{i+1}. #{t.utc.strftime("%H:%M:%S.%2N")}" }
                   .join("\n")
  end
end

# PROTIP: Think of a module as a specific kind of
#         class that only has static methods/variables

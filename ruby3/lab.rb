class BashHistory
  attr_reader :lines

  def initialize file_path
    @lines = File.readlines(file_path)
    @rx1 = /^
            ([\w\-]+)   #first word
            (\s*)       #spaces
           /x

    @rx2 = /^
            ([\w\-]+)   #first word
            (\s*)       #spaces
            ([\w\-]+)   #second word
           /x
    @parsed = self.to_array_of_hashes
  end

  def to_array_of_hashes
    @lines.map do |line|
      hash = {}
      mm = line.match(@rx1)
      unless mm.nil?
        captures = line.match(@rx1).captures
        if captures[0] == 'sudo' and captures[1] != ''
          captures = line.match(@rx2).captures
          hash.merge({sudo: true, command: captures[2]})
        else
          hash.merge({sudo: false, command: captures[0]}) 
        end
      end
    end.compact
  end

  def stats
    qnt = @lines.size
    sudo_qnt = 0
    commands = {}
    hash =  { lines_count: qnt }
    @parsed.each do |e|
      if e[:sudo]
        sudo_qnt += 1
      end
      commands[e[:command]] ||= 0
      commands[e[:command]] += 1
    end
    hash.merge({ 
              sudo_calls_count:   sudo_qnt,
              sudo_calls_percent: sudo_qnt.to_f*100/qnt,
              command_calls: commands
            })
  end

  def stats_to_text
    hash = self.stats
    puts "------------------------------------------------"
    puts "Lines: #{hash[:lines_count]}"
    puts "Sudo calls: #{hash[:sudo_calls_count]}"
    puts "Sudo calls percent: #{hash[:sudo_calls_percent]}"
    puts "------------------------------------------------"
    puts "Commands:"
    hash[:command_calls].each do |key, value|
      puts "#{key} called #{value} times"
    end
    return true
  end
end

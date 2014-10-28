class Array
  def thread_split_call method_name, num, &block
    modulo = self.size % num
    quotient = self.size.div(num)

    threads = (1..num).map do |thread_num|
      if thread_num <= modulo
        first = (thread_num - 1) * (quotient + 1)
        last = first + quotient
      else
        first = (thread_num - 1) * quotient + modulo
        last = first + quotient - 1
      end

      Thread.new do
        self[first..last].send(method_name, &block)
      end
    end
    threads.map {|e| e.value}
  end

  def pmap num, &block
    thread_split_call('map', num, &block).flatten 1
  end

  def pany? num, &block
    thread_split_call('any?', num, &block).any?
  end

  def pall? num, &block
    thread_split_call('all?', num, &block).all?
  end

  def pselect num, &block
    thread_split_call('select', num, &block).flatten 1
  end
end

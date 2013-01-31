require 'test/unit'
require 'multi_sort'

  class TestDocument
    attr_reader :a, :b, :c
    def intialize
       @a = rand + rand
       @b = 2 * rand # same mean as @a, but more varaiance
       @c = 3 + rand - @a # anti-correlated with @a
    end
  end

  class TestSource
    attr_reader :name
    def intialize(name, data, value_proc)
      @name = name
      @sort_block = sort_block
      @data = data
    end

    def pull(limit)
      @data.sort_by{|d|value_proc.call(d)}[0...limit]
    end
  end

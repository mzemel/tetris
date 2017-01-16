class Score
  class << self
    attr_accessor :longest
    attr_reader :score

    def longest
      @@longest ||= 0
    end

    def longest=(n)
      @@longest = n
    end

    def score
      @@score ||= 0
    end

    def add(n)
      @@score += n
    end

    def subtract(n)
      @@score -= n
    end
  end
end
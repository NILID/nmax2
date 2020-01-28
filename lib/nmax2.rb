require 'nmax2/version'

module NMax2
  def self.get(stdin:, count:)
    return '== Count should not be a negative number ==' if count < 0
    return '== Empty output. Count should be a number and greater than 0 ==' if count == 0

    file = stdin.each_line

    collection = []

    file.each_entry do |line|
      integers = line.scan(/\d+/)
      integers.map { |i| collection.push i.to_i }
    end

   return '== There are no numbers in file ==' if collection.size == 0
    collection.sort { |a, b| b <=> a }.take(count)
  end
end

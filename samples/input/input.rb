#wip
class Input
  end

file = ARGV.first
input = File.read(file)

puts "here's the input i got:"
puts input.split('\n')
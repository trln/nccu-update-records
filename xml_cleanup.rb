#!/usr/bin/ruby

file = ARGV[0]

File.open(file,'r').each do |line|
  puts line.scrub('�').gsub(/[^[:print:]|\n]/i, '�')
end


#!/usr/bin/env ruby 

d = Dir.open(Dir.getwd)
d.entries.reject { |d| 
  d.start_with? "."
}.find_all { |d| 
  d.end_with? ".hs" 
}.each do |d|
  props = []
  f = File.open d
  f.readlines.each do |l|
    if l.start_with? "prop_"
      p = l.split(" ")[0]
      props << p
    end
  end
  props.uniq!
  if props
    puts "Testing #{d}"
    IO.popen("ghci #{d} 2> /dev/null", "w+") do |pipe|
      pipe.puts "import Test.QuickCheck"
      errors = []
      props.each do |p|
        pipe.puts "quickCheck #{p}"
        pipe.close_write
        output = pipe.read
        pipe.reopen pipe
        if output.include? "OK, passed 100 tests."
          print "."
        else
          print "X"
          errors << p
        end
      end
      
      if errors
        puts "Failed:"
        errors.each do |e|
          puts e
        end
      end
    end
  end
  
  
end


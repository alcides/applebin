require 'rubygems'
require 'icalendar'
 
path   = File.expand_path("~/Library/Calendars")
tasks   = []
 
Dir.glob("#{path}/*.calendar").each do |item|
  Dir.glob("#{item}/Events/*.ics").each do |calendar|
    file     = File.open(calendar)
    calendars   = Icalendar.parse(file)
    
    calendars.each do |calendar|
      tasks.concat(calendar.todos) if calendar.todos.length > 0
    end
  end
end
 
if tasks.length > 0
  tasks.sort! { |a, b| b.dtstamp <=> a.dtstamp }
 
  tasks.each do |task|
    puts "> #{task.summary}"
  end
end
require 'paint'
require 'terminal-table'

class Question
  def initialize()
    @days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    @results = {}
  end

  attr_accessor :days, :results
end



question1 = Question.new() #Create question class

def is_number? string #method to check input is a number
  true if Float(string) rescue false
end

def celsius_tofah(celsius_input) #method to convert C to F
    fah = (celsius_input * 9) / 5 + 32
    return fah
end



def askQuestion(day) #method to ask question for each day in days
  puts "
  What was the temp on #{day} ?"

  answer = gets.chomp

  if is_number?(answer) #check answer is a number
    answer = answer.to_i

    if !answer.between?(-100, 80) #check anser is a sensible temp

        puts "Temp not relistic. Try Again..."
        askQuestion(day)

    else
      puts "Input recorded"
      return answer
    end
  else
    puts "Answer is not a number! Please try again."
    askQuestion(day)
  end
end


###### MAIN CODE #######

  for day in question1.days
#add days to has as keys
    answer = askQuestion(day)
    f = celsius_tofah(answer)
    question1.results[day] = [['C', answer],['F',f]]
  end

  puts "Results "
  puts question1.results.inspect


  rows = []
  rows << ['DAY', 'C', 'F']
  rows << :separator
  question1.results.each do |key, value|
    # puts key
    # puts value
    c = value[0][1] # get C value ready to paint (if needed)
    f = value[1][1]
    if value[0][1] < 10 #if cold, paint blue
      c = Paint[value[0][1], :blue]
      f = Paint[value[1][1], :blue]
    elsif value[0][1] > 29 #if got, paint red
      c = Paint[value[0][1], :red]
      f = Paint[value[1][1], :red]
    end

    rows << [key, c, f] #display row by row
  end

  table = Terminal::Table.new :rows => rows

puts table

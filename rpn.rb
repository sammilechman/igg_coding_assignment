#!/usr/bin/env ruby

def ctoi(char)
  return_i = char.ord - "0".ord
  if return_i.class != Fixnum
    puts "invalid number"
    exit
  end
  return_i
end

p ctoi("0")
p ctoi("p")
p ctoi('9')

def atoi(str)
  total = 0
  str.length.times do |x|
    total += ctoi(str[str.length-1-x]) * (10 ** x)
  end
  total
end

def atof(str)
  arr_of_str = str.split(/\D/)
  if arr_of_str.length == 2
    total = 0
    int, frac = arr_of_str[0], arr_of_str[1]
    total + atoi(int) + (1.0 * atoi(frac) / (10 ** frac.length))
  elsif arr_of_str.length == 1
    1.0 * atoi(str)
  else
    puts "This is not a valid float."
  end
end

def start
  array = ARGV[0].split(" ")
  calculate(array)
end

def calculate(arr)
  ending_arr = []

  if ending_arr.length == 1
    ending_arr.first
  else
    calculate(ending_arr)
  end
end

# start

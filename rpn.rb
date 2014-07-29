#!/usr/bin/env ruby

def ctoi(char)
  return_i = char.ord - "0".ord
  if return_i < 0 || return_i > 9
    puts "invalid number"
    exit
  end
  return_i
end

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
  finished_arr = []
  operators = ["+", "-", "*", "/"]
  start_pos = 0

  arr.each_index do |idx|
    if operators.include?(arr[idx])
      to_perform = arr[start_pos..idx]

      if to_perform.length < 3
        to_perform = finished_arr << to_perform
      end

      finished_arr << perform_op(to_perform)
      start_pos = idx + 1
      p start_pos
    end
  end

  if finished_arr.length == 1
    finished_arr.first
  else
    arr = finished_arr << arr[start_pos..-1]
    p arr
    calculate(arr)
  end
end

def perform_op(arr)
  if arr.length < 3
    puts "not enough arguments"
    exit
  elsif arr.length == 3
    case arr.last
    when "+"
      return atof(arr[0]) + atof(arr[1])
    when "-"
      return atof(arr[0]) - atof(arr[1])
    when "*"
      return atof(arr[0]) * atof(arr[1])
    when "/"
      return atof(arr[0]) / atof(arr[1])
    else
      puts "invalid operator"
      exit
    end
  end
end

start

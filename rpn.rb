#!/usr/bin/env ruby

def ctoi(char)
  return_i = char.ord - "0".ord
  if return_i < 0 || return_i > 9
    p char
    puts "Invalid number"
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
  # return str if str.class == Fixnum || str.class == Float
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

def ftoi(str)
  #Simplifies result from float to int if possible.
  arr = str.split(".")
  return atoi(arr[0]).to_s if arr[1] == "0"
  arr.join(".")
end

def start
  #Grabs argument from command line
  array = ARGV[0].split(" ")
  calculate(array)
end

def calculate(arr, stack = [])
  puts "Array: " + arr.to_s
  puts "Stack: " + stack.to_s
  puts " "
  operators = ["+", "-", "*", "/"]

  if arr.length == 3 && stack.empty?
    val1, val2, op = arr.shift, arr.shift, arr.shift
    result = perform_op(op, val1, val2)
    puts "The result of the calculation is: " + ftoi(result)
    return
  elsif arr.length <= 1 && !stack.empty?
    new_arr = []
    stack.each_index{ |i| new_arr << stack[stack.length-1-i] }
    new_arr += arr
    calculate(new_arr, [])
  elsif operators.include?(arr.first)
    if stack.length < 2
      puts "Not enough arguments."
      exit
    else
      val2, val1 = stack.shift, stack.shift
      result = perform_op(arr.shift, val1, val2)
      stack.unshift(result)
      calculate(arr, stack)
    end
  elsif stack.length == 1 && arr.empty?
    calculate(stack, arr)
  else
    stack.unshift(arr.shift)
    calculate(arr, stack)
  end

end

def perform_op(op, val1, val2)
  case op
  when "+"
    return (atof(val1) + atof(val2)).to_s
  when "-"
    return (atof(val1) - atof(val2)).to_s
  when "*"
    return (atof(val1) * atof(val2)).to_s
  when "/"
    return (atof(val1) / atof(val2)).to_s
  else
    puts "Invalid operator."
    exit
  end
end

start

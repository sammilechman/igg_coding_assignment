#!/usr/bin/env ruby

def atof(str)
  arr_of_str = str.split(/\D/)
  if arr_of_str.length == 2
    total = 0
    int, frac = arr_of_str[0], arr_of_str[1]
    total + atoi(int) + (1.0 * atoi(frac) / (10 ** frac.length))
  elsif arr_of_str.length == 1
    1.0 * atoi(str)
  else
    puts "Invalid number."
    exit
  end
end

def atoi(str)
  total = 0
  str.length.times do |x|
    total += ctoi(str[str.length-1-x]) * (10 ** x)
  end
  total
end

def calculate(arr, stack = [])
  operators = ["+", "-", "*", "/"]

  #Down to the last operation...
  if arr.length == 3 && stack.empty?
    val1, val2, op = arr.shift, arr.shift, arr.shift
    result = perform_op(op, val1, val2)
    puts "The result is: " + ftoi(result)
    return

  #Time for an operation...
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

  #Reattach stack to arr...
  elsif arr.length <= 1 && !stack.empty?
    new_arr = []
    stack.each_index{ |i| new_arr << stack[stack.length-1-i] }
    new_arr += arr
    calculate(new_arr, [])

  #Left with our answer...
  elsif stack.length + arr.length == 1
    puts "The result is: " + ftoi((stack + arr).first)
    exit

  #Simple case, shift off array onto the stack...
  else
    stack.unshift(arr.shift)
    calculate(arr, stack)
  end
end

def ctoi(char)
  return_i = char.ord - "0".ord
  if return_i < 0 || return_i > 9
    puts "Invalid number."
    exit
  end
  return_i
end

def ftoi(str)
  #Simplifies result from float to integer if possible.
  #First, sanitize negative sign.
  if str[0] == "-"
    negative = true
    str[0] = ""
  end

  num = integer_check_stringify(str.split("."))

  #Return negative sign if applicable.
  if negative
     "-" + num
  else
     num
  end
end

def integer_check_stringify(arr)
  #If it only has 0 after decimal, it's an integer.
  if arr[1] == "0"
    arr[0].to_s
  else
    arr.join(".")
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

def start
  #Grabs argument from command line
  array = ARGV[0].split(" ")
  calculate(array)
end

start

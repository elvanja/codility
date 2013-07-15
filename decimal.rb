def period(string)
  string_period = nil
  (1..(string.size / 2)).each do |period|
    valid = true
    (0..(string.size - period - 1)).each do |k|
      valid = false and break if string[k] != string[k + period]
    end
    string_period = period if valid && period <= (string_period || period)
    break if string_period && string_period == 1
  end
  string_period || -1
end

def get_remainder(number)
  remainder = number.to_s
  /\de-(?<exponent>\d+)/ =~ remainder
  return remainder.split("e")[0].gsub(".", "").prepend("0" * (exponent.to_i - 1)) if exponent
  remainder.split(".")[1]
end

def solution(a, b)
  real = a.fdiv(b)
  whole = a / b
  return "#{whole}" if real - whole == 0

  non_repeatable = ""
  repeatable = ""
  remainder = get_remainder(real)

  (0..(remainder.size - 1)).each do |i|
    period = period(remainder[i..-1])
    non_repeatable += remainder[i] and next if period == -1
    repeatable = "(#{remainder[i..(i + period - 1)]})"
    break
  end

  "#{whole}.#{non_repeatable}#{repeatable}"
end

require 'rspec'

describe "#solution calculates decimal representation" do
  it "with no remainder" do
    solution(16, 4).should == "4"
  end

  it "with nice remainder" do
    solution(5, 2).should == "2.5"
    solution(3, 4).should == "0.75"
    solution(11, 10).should == "1.1"
    solution(9, 4).should == "2.25"
  end

  it "with repeating remainder" do
    solution(4, 3).should == "1.(3)"
    solution(1, 3).should == "0.(3)"
  end

  it "with long repeatable remainder" do
    solution(1, 7).should == "0.(142857)"
  end

  it "with given examples" do
    solution(3, 1).should == "3"
    solution(4, 2).should == "2"
    solution(5, 2).should == "2.5"
    solution(3, 4).should == "0.75"
    solution(11, 10).should == "1.1"
    solution(1, 3).should == "0.(3)"
    solution(3, 28).should == "0.10(714285)"
    solution(12, 3).should == "4"
    solution(1, 2).should == "0.5"
    solution(5, 4).should == "1.25"
  end

  it "with large numbers" do
    solution(1_000_000, 1_000_000).should == "1"
    solution(1_000_000, 3).should == "333333.(3)"
    solution(1, 100_001).should == "0.(0000099999)"
    #solution(1, 500_017).should == "0.0000019999320023119215"
  end

  it "with division by large numbers" do
    solution(1, 999_999).should == "0.(000001)"
    solution(1, 999_000).should == "0.000(001)"
  end
end

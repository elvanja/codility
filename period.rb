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

def solution(n)
  period(n.to_s(2))
end

require 'rspec'

describe "#period calculates string period" do
  it "when single character" do
    period("1").should == -1
  end

  it "with two characters" do
    period("00").should == 1
    period("11").should == 1
    period("10").should == -1
    period("01").should == -1
  end

  it "with three characters" do
    period("000").should == 1
    period("111").should == 1
    period("101").should == -1
    period("010").should == -1
    period("011").should == -1
  end

  it "with large one that has a period" do
    period("11101110011110111001111011100111").should == 10
  end

  it "with given examples" do
    period("1110111011").should == 4
    period("1100110").should == -1
  end
end

describe "#solution calculates binary period of a number" do
  it "with given examples" do
    solution(955).should == 4
    solution(102).should == -1
  end

  it "with large number that has a period" do
    solution(4_001_079_015).should == 10
  end

  it "with max number" do
    solution(1_000_000_000).should == -1
  end
end

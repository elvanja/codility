require 'rspec'

#Devise a function that takes an input 'n' (integer) and returns a string that is the
#decimal representation of that number grouped by commas after every 3 digits. You can't
#solve the task using a built-in formatting function that can accomplish the whole
#task on its own.
#
#Assume: 0 <= n < 1000000000
#
#1 -> "1"
#10 -> "10"
#100 -> "100"
#1000 -> "1,000"
#10000 -> "10,000"
#100000 -> "100,000"
#1000000 -> "1,000,000"
#35235235 -> "35,235,235"

def solution(n)
  stringified = n.to_s

  separated = ""
  stringified.reverse.split("").each_with_index do |digit, index|
    separator = (index % 3 == 0 && index != 0)? "," : ""
    separated = "#{digit}#{separator}#{separated}"
  end
  separated
end

describe "decimal representation" do
  it "represents 1" do
    expect(solution(1)).to eq("1")
  end

  it "represents 10" do
    expect(solution(10)).to eq("10")
  end

  it "represents 100" do
    expect(solution(100)).to eq("100")
  end

  it "represents 1000" do
    expect(solution(1_000)).to eq("1,000")
  end

  it "represents 10000" do
    expect(solution(10_000)).to eq("10,000")
  end

  it "represents 100000" do
    expect(solution(100_000)).to eq("100,000")
  end

  it "represents 1000000" do
    expect(solution(1_000_000)).to eq("1,000,000")
  end

  it "represents 35235235" do
    expect(solution(35_235_235)).to eq("35,235,235")
  end
end

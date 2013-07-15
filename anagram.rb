require 'rspec'

#Devise a function that gets one parameter 'w' and returns all the anagrams for 'w' from the file
#wl.txt.
#
#"Anagram": An anagram is a type of word play, the result of rearranging the letters of a word or
#phrase to produce a new word or phrase, using all the original letters exactly once; for example
#orchestra can be rearranged into carthorse.
#
#anagrams("horse") should return:
# ['heros', 'horse', 'shore']

def calculate_anagram_value(word)
  word.split("").sort.join
end

describe "#calculate_anagram_value calculates value to which the word compares as anagram" do
  it "returns self for one lettered words" do
    calculate_anagram_value("a").should == "a"
  end

  it "returns sorted letters for the rest" do
    calculate_anagram_value("cba").should == "abc"
  end

  it "takes repeated letters into account" do
    calculate_anagram_value("cbcabc").should == "abbccc"
  end
end

def anagramify(dictionary)
  hash = Hash.new([])
  dictionary.each do |word|
    hash[calculate_anagram_value(word)] += [word]
  end
  hash
end

describe "#anagramify dictionary" do
  it "calculates anagram values for all the words in the dictionary" do
    expect(anagramify(["abba", "bomb"])).to eq({"aabb" => ["abba"], "bbmo" => ["bomb"]})
  end
end

def anagrams(word, dictionary = [])
  return [] if dictionary.empty?
  hash = anagramify(dictionary)
  hash[calculate_anagram_value(word)]
end

describe "calculates anagrams from given dictionary" do
  it "has no anagrams for empty dictionary" do
    dictionary = []
    expect(anagrams("word", dictionary)).to eq([])
  end

  it "returns self as anagram if present in dictionary" do
    dictionary = ["word"]
    expect(anagrams("word", dictionary)).to eq(["word"])
  end

  it "has no anagrams if none exist in dictionary" do
    dictionary = ["play"]
    expect(anagrams("word", dictionary)).to eq([])
  end

  it "returns anagrams if present in dictionary" do
    dictionary = ["word", "drow", "play"]
    expect(anagrams("word", dictionary)).to eq(["word", "drow"])
  end
end

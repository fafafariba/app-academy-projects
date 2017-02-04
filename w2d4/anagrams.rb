def first_anagram?(word1, word2) # O(n!)
  anagrams = word1.chars.permutation.to_a.map { |el| el.join}  #n!
  anagrams.include?(word2) # n! * n
end

first_anagram?("sally","gizmo")


def second_anagram?(word1, word2) # O(n^2)
  letters1 = word1.chars # O(n)
  letters2 = word2.chars

  word1.each_char.with_index do |letter, i| # O(n)
    j = letters2.index(letter) #  + O(n) or * O(n)
    if j.nil?
      break
    else
      letters2.delete_at(j)
      d = letters1.index(letter)
      letters1.delete_at(d)
    end
  end
  letters2.empty? && letters1.empty? # O(1)
end

second_anagram?("sally","gizmo")
second_anagram?("lives","elvis")

def third_anagram?(word1, word2) # O(n log n)
  word1.chars.sort == word2.chars.sort
end

third_anagram?("sally","gizmo")
third_anagram?("lives","elvis")


def fourth_anagram?(word1, word2) #O(n)
  hash = Hash.new(0)

  word1.each_char do |letter|
    hash[letter] += 1
  end

  word2.each_char do |letter|
    hash[letter] -= 1
  end

  hash.values.all? { |v| v == 0 }
end

p fourth_anagram?("sally","gizmo")
p fourth_anagram?("lives","elvis")

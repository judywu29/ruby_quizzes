Ruby Quizzes
================

Writing some quizzes in ruby in fun and good practise to solve the problem in ruby language. 
I will update this continually. 
So far, I've done 3 quizzes:

 - Finding the longest repeated substring
 - From Integer to Roman Numeral
 - From Roman Numeral to Integer
 
Finding the longest repeated substring
================
I solved this problem by using the suffix tree: 
The idea of a suffix tree is to build a list of every suffix that occurs in the text. Thus the quiz example "banana" breaks down to:

banana
 anana
  nana
   ana
    na
     a

That may not look like a lot of help yet, but watch what happens if we sort the entries:

a
ana
anana
banana
na
nana

See how the common prefixes group together? We can now compare adjacent entries of our suffix tree for prefixes they have in common. 
In this case, the second and third element share an "an" and that's one of the possible answers. 
Note that the second and third share "ana" as well, but selecting that one causes overlap:

[ana]na
  [ana]

From Integer to Roman
================
Converting a number to a Roman numeral is a bit more tricky because some Roman numerals are irregular 
(e.g. 4 equals IV, not IIII). The number to Roman numeral mapping is updated to reflect the irregular Roman numerals.

The Roman numeral is constructed by iterating over every element in the mapping, performing integer division, 
appending letters to the result, and continuing the process with the remainder of the integer division (aka the modulus). 
For example, 3100 goes into 1000 three times with a remainder of 100. Three “M”s are appended to the result and the iteration 
continues with the remainder. 100 goes into 100 one time with a remainder of 0, so the final result if MMMC.

We can build this mapping first: 
def roman_mapping
    {
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
    }
  end

From Roman to Integer
================
A Roman numeral like “LXIV” can be converted to 64 by iterating through all the letters, converting each letter to a number, 
and summing the numbers. Numbers that are less than the subsequent number are treated as negative to account for irregularities 
in Roman numeral notation.
We still can use the roman_mapping. 





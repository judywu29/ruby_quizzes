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

From postfix to infix
=======================

Requirement for the quiz: 

	There are many different ways to write mathematical equations. Infix notation is probably the most popular and yields expressions like:
	
	2 * (3 + 5)
	
	Some people like to work with a postfix notation (often called Reverse Polish Notation or just RPN) though, which doesn't require 
	parentheses for the same equation:
	
	2 3 5 + *
	
	You can compare the results of these equations using the Unix utilities bc (infix) and dc (postfix):
	
	$ bc <<< '2 * (3 + 5)'
	16
	$ dc <<< '2 3 5 + * p'
	16
	
	The "p" instruction tacked onto the end of the expression for dc just tells it to print the result.
	
	The quiz is to write a script that translates postfix expressions into the equivalent infix expression. In the simplest form, 
	The script should function as such:
	
	$ ruby postfix_to_infix.rb '2 3 +'
	2 + 3
	
	At minimum, try to support the four basic math operators: +, -, *, and /. Feel free to add others though. For numbers, 
	remember to accept decimal values.
	
	You can count on the postfix expressions having spaces between each term, if you like. While dc is content with 2 3+p, 
	you don't have to support it unless you want to.
	
	For an added bonus, try to keep the parentheses added to infix expressions to the minimum of what is needed. For example, 
	prefer these results:
	
	$ ruby postfix_to_infix.rb '56 34 213.7 + * 678 -'
	56 * (34 + 213.7) - 678
	$ ruby postfix_to_infix.rb '1 56 35 + 16 9 - / +'
	1 + (56 + 35) / (16 - 9)
	
	to these:
	
	$ ruby postfix_to_infix.rb '56 34 213.7 + * 678 -'
	((56 * (34 + 213.7)) - 678)
	$ ruby postfix_to_infix.rb '1 56 35 + 16 9 - / +'
	(1 + ((56 + 35) / (16 - 9)))

I just use a 2 dimention array to store the string and its priority. When it's a number, just push into the stack with its
default priority(1) and when it's a operator, I pop the 2 elements, check if braces are needed by comparing their priorities. 
and then perform the requested operation, and push the result back into the stack.
And finally there will be 1 element inside. 

Happy number
=================
Write a program that tells whether a given integer is happy. A happy number is found using the following process: 
Take the sum of the squares of its digits, and continue iterating this process until it yields 1, or produces an infinite loop.

For example the number 7:

7^2 = 49
4^2 + 9^2 = 97
9^2 + 7^2 = 130
1^2 + 3^2 + 0^2 = 10
1^2 + 0^2 = 1

If a number is not happy than it is obviously unhappy. Now that you have this program, what is the largest happy number you can find? 
What is the happiest number between 1 and 1,000,000. The happiest number as the smallest number that finds the most other happy numbers 
with it, i.e. 7 found four other numbers (49, 97, 130, and 10) making it a rank 4 in happiness.

About the unhappy number, there's a pattern here: 
0: 0
4:  16 37 58 89 145 42 20 4 
16: 37 58 89 145 42 20 4 16
20: 4 16 37 58 89 145 42 20
37: 58 89 145 42 20 4 16 37
42: 20 4 16 37 58 89 145 42
58: 89 145 42 20 4 16 37 58
89: 145 42 20 4 16 37 58 89
145:42 20 4 16 37 58 89 145

I mainly took 2 steps to achive this: 
 - get the rank of happiess of each number, in order to reduce the calculation, the zeros in the digits can be deleted and sharing the
 same digits with different orders are calcuated once. I used a hash(@sum_of_digits) to store the sum result of those digits after deleting
 the zeros and ordering. and those sum hits the unhappy number, rank is set to 0. 
 
 - and then traverse their ranks and get the highest rank. 
 
Index and Query
=================
Requirement: 

If you have: 

Doc1=The quick brown fox

Doc2=Jumped over the brown dog

Doc3=Cut him to the quick

You can build a table with bit number and word.

	1 the
	2 quick
	3 brown
	4 fox
	5 jumped
	6 over
	7 dog
	8 cut
	9 him
	10 to
	11 quick

To create indices:

	Doc1=00000001111
	Doc2=00001110101
	Doc3=11110000011

You can very quickly return the Docs that contain 'the' [ Doc1,Doc2,Doc3 ], or brown [ Doc1,Doc2 ] etc. 

Solution:

I use 2 Hashes, one is for the term to keep the term and its unique index across all of the files. as this: 
	key    value
	the     1
	quick   2
	brown   3
	fox     4
	jumped  5
	over    6

Once you have an index for the new term, it's time to record it in the index Hash, under the current document name. 
Each document name is given a single Integer for a value. The bit at the term index is then just flipped on to indicate the presence 
of a term. This will make for some big numbers, but Ruby will automatically switch to Bignum as needed.


result: 

	ruby index_and_query.rb add "doc1" "doc2" "doc3"
	ruby index_and_query.rb find "the"
	["doc1", "doc2", "doc3"]
	192-168-1-3:index_and_query judy$ ruby index_and_query.rb find "brown"
	["doc1", "doc2"]
	192-168-1-3:index_and_query judy$ ruby index_and_query.rb find "brown" "the"
	["doc1", "doc2", "doc1", "doc2", "doc3"]
	192-168-1-3:index_and_query judy$ ruby index_and_query.rb find "brown" "the" "cut"
	["doc1", "doc2", "doc1", "doc2", "doc3", "doc3"]
	ruby index_and_query.rb dump
	the: 
	doc1
	doc2
	doc3
	quick: 
	doc1
	doc3
	brown: 
	doc1
	doc2
	fox: 
	doc1
	jumped: 
	doc2
	over: 
	doc2
	dog: 
	doc2
	cut: 
	doc3
	him: 
	doc3
	to: 
	doc3

Werid Numbers
=================
A weird number is defined as a number, n, such that the sum of all its divisors (excluding n itself) is greater than n, 
but no subset of its divisors sums up to exactly n.

We can rule out some numbers: 
First of all, there are no known odd weird numbers, so we might as well toss out half of the set right off the bat. 
(It's possible there are some very large odd weird numbers, but we would have trouble calculating those anyway.) 
Weird number is also an abundant number. This is easy to check. (Sum of the divisors is greater than 2 times of itself.)
Werid number is not a semi-perfect number which means the sum of part of its divisors cannot be equal to itself. 

I will eliminate those numbers to get the weird number. The smallest weird number starts from 70. 

Numeric Maze
=================
We have a starting point and a target, say 2 and 9. We have a set of three operations:

double
halve    (Odd numbers cannot be halved.)
add_two

Problem: Move from the starting point to the target, minimizing the number of operations.

Examples:

solve(2,9)  # => [2,4,8,16,18,9]
solve(9,2)  # => [9,18,20,10,12,6,8,4,2]

We can use of bit operations, because they tend to be faster than multiplication and division. All we need to know about these is 
that n << 1 == n * 2 and n >> 1 == n / 2.
I use a instance variable to store all of the numbers to prevent repetition calculation when going through the numbers of each path. 
They are a lot of repetition. So only new numbers are needed to calculate next time. 
The controversion method - find_path will go as deep as there are steps in the solution. 
Everytime, I take the last number(newly added) to calculate and push the result into the new_path if the number has never been calculated.
I use 2 dimention array to record all of the paths(new_path), each dimention is the result of each operation.

2
  2, 4  (double)
    2, 4, 8  (double)
      2, 4, 8, 16  (double)
      2, 4, 8, 4   (halve)
      2, 4, 8, 10  (add two)
    2, 4, 2  (halve)
      2, 4, 2, 4  (double)
      2, 4, 2, 1  (halve)
      2, 4, 2, 4  (add two)
    2, 4, 6  (add two)
      2, 4, 6, 12  (double)
      2, 4, 6, 3   (halve)
      2, 4, 6, 8   (add two)
  2, 1  (halve)
    2, 1, 2  (double)
      2, 4, 2, 4  (double)
      2, 4, 2, 1  (halve)
      2, 4, 2, 4  (add two)
    2, 1, 3  (add two)
      2, 4, 3, 6  (double)
      2, 4, 3, 5  (add two)
  2, 4  (add two)
    2, 4, 8  (double)
      2, 4, 8, 16  (double)
      2, 4, 8, 4   (halve)
      2, 4, 8, 10  (add two)
    2, 4, 2  (halve)
      2, 4, 2, 4  (double)
      2, 4, 2, 1  (halve)
      2, 4, 2, 4  (add two)
    2, 4, 6  (add two)
      2, 4, 6, 12  (double)
      2, 4, 6, 3   (halve)
      2, 4, 6, 8   (add two)

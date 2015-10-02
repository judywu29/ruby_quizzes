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
What is the happiest number between 1 and 1,000,000.




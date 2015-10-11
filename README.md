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
	      
Current Temperature
==================
Write a Ruby program such that given a certain argument to the program it will return the current temperature of that location. 
People living in the United States may be interested in temperature by ZIP code:

$ ruby current_temp.rb 47201
The temperature in Columbus, Indiana is 32 degrees F.

Other locales may want to use their own mailing codes, or city names:

$ ruby current_temp.rb madrid
The temperature in Madrid, Spain is 12 degrees C.

Which arguments you support is up to you.

This time I will play around with web service. 
Web services represent a predefined communication protocol. We pass the information the service expects in, 
and it will return a promised response. 
At first, we have to build the URL which points to the document describing the web service (a Web Service Description Language, 
or WSDL, document). Another standard library, SOAP, is used to read and parse that document. In doing so, 
it will build a custom object that has the methods provided by the service, accepting the arguments they expect.

Searched for "SOAP in Ruby", and Savon is pretty much the only option. 

Using Savon
The first thing you need to do to use Savon (after installing the Gem) is to create yourself a client. 
You can even ask the client which operations are available. It will parse through the WSDL file to generate an array of 
operations/methods you can call.

client = Savon.client(wsdl: "http://www.webservicex.net/globalweather.asmx?WSDL")
client.operations # => [:get_weather]
Next up you can make the request. It is sent using a plain Ruby Hash.

response = client.call(:get_weather, message: { CityName: "Sydney", CountryName: "Australia" })
What you'll get back is a response object which has a header method and a body method. The body method contains a hash, 
which might look something like this:

That's not so bad! Savon provides a very nice interface, so you rarely need to deal with XML or WSDL files directly. 
It's a good idea to understand them, which will help you troubleshoot, but for the most part you're just working with Ruby Hashes.

Word Munge
===================
This quiz is to take a text as input and output a new text. Scramble each word's center (leaving the first and last letters of 
each word intact). Whitespace, punctuation, numbers -- anything that isn't a word -- should also remain unchanged.

The munge algorithm is easy. we just need split to array and sort_by(rand) and then join the first, center and last characters.

When we handle unicode, like split the word 'rsuémé', if I use split(""), it would split the multi-byte character up. 
["s", "u", "\xC3", "\xA9", "m", "\xC3", "\xA9"], e.g. é has been splitted into "\xC3", "\xA9"
We have to convert the string read from the file to 'UTF-8': 
    self.encode("ASCII-8BIT").force_encoding("utf-8")

and then we use the split(""), it will handle it correctly. it outputs :
	["s", "u", "é", "m", "é"]
  
even for the Chinese, it can handle properly. 
input: 这是测试文件
output: 这试文是测件

ruby word_munge.rb test
Atactehd is my rmsuéé. 这是文测试件

Bracket Packing
=======================
I just found an interesting quiz about checking the missing brackets. 
The BigCo Bracket Company, one of the world's largest suppliers of brackets, hinges and fittings, has lately been experiencing 
problems in it's manufacturing division, with a large number or brackets lost or broken in transit owing to faulty packaging 
at the end of the line.

Investigations into the cause of the problem have led engineers to an ancient COBOL program controlling the packaging machinery. 
This program is responsible for selecting the type of packaging a given bracket should be shipped in, based on input from an 
array of sensors on the production line. It then sends a description of the package to the packager itself, which packs the 
bracket and sends it on to shipping. The description is a simple text string, made up of brackets with the following format:

(B)     - Bracket in a soft wrapping
[B]     - Bracket in a cardboard box
{B}     - Bracket in a wooden box

Often, brackets have multiple layers of packaging for protection, for example:

{(B)}   - Soft-wrapped bracket in a wooden box
[{B}]   - Wooden-boxed bracket with cardboard outer

[{(B)}{(B)(B)}] - Wooden boxed single and double bracket packs with soft
                  inner wrap, in cardboard outer. 

Now, the problem is that this venerable program has for some reason begun to output malformed packaging descriptions, 
occasionally missing off a bracket, for example:

	[{(B}{(B)(B)}]

or:

	{(B)}{(B)(B)}]

After a fruitless search for someone with the skills to fix this problem, the engineers changed tack and called you in to 
fix the problem from the outside.

Solution: 

- for checking the string - "[{(B}{(B)(B)}] "if it's valid, I just used a loop to do replacement if it matches the four case:
/(\{B\}|\[B\]|\(B\)|BB)/, everytime, it replaces with "B", if the final string is a 'B', and it's valid. Or else, it's invalid. 

- for correcting the string, I used a stack to push the closer when it runs into an opener. The stack is popped until I find 
the correct closer or empty the stack.So at the end, it will complete the opened sets. and then handle the pairs that were 
never opened. I reversed it and then all closers becomes opener and then used the same way as the last step to fix the missing
closers. 

Hash to OpenStruct
====================
To convert a nested hash structure into a nested OpenStruct

Sample yaml file: 
	
		---
		foo: 1
		bar:
		  baz: [1, 2, 3]
		  quux: 42
		  doctors:
		    - William Hartnell
		    - Patrick Troughton
		    - Jon Pertwee
		    - Tom Baker
		    - Peter Davison
		    - Colin Baker
		    - Sylvester McCoy
		    - Paul McGann
		    - Christopher Eccleston
		    - David Tennant
		  a: {x: 1, y: 2, z: 3}

Comparing the code using hash and openstruct: when access to the data 

    @data = YAML::load(File.open('sample.yaml'))
    p @data['foo']
    p @data['bar']['baz']
    p @data['bar']['quux']
    p @data['bar']['doctors']
    p @data['bar']['a']['x'] 
    
Apparently, it's cleaner when we access to the 'OpenStruct':
    
	  @data = self.converting_to_openstruct(YAML::load(File.open('sample.yaml')))
      p @data.foo
      p @data.bar.baz
      p @data.bar.quux
      p @data.bar.doctors
      p @data.bar.a.x
      
	  #<OpenStruct foo=1, bar=#<OpenStruct baz=[1, 2, 3], quux=42, doctors=["William Hartnell", "Patrick Troughton", "Jon Pertwee", 
	  "Tom Baker", "Peter Davison", "Colin Baker", "Sylvester McCoy", "Paul McGann", "Christopher Eccleston", "David Tennant"], 
      a=#<OpenStruct x=1, y=2, z=3>>>

pp Pasca
==============
To print Pascal's Triangle:
It's a pyramid of numbers. The outside of the pyramid is all ones, the other numbers are the sum of the two numbers above, 
like this:
	
		    1    
		   1 1   
		  1 2 1  
		 1 3 3 1 
		1 4 6 4 1

The key is here to calculate the maximum length of the number of the last row. and then we know the space to leave for each num
in each row.(leave 3*length for the space between 2 numbers) After that, I again use center method to print each row in the 
center of the last row. 


day range
==============

To create a method to convert a list of days into a more human-readable string.

For example, suppose a musician plays at a certain venue on Monday, Tuesday, Wednesday, and Saturday. 
We could pass a list of associated day numbers to your object or method, which might return "Mon-Wed, Sat".

The purpose of this quiz is to find the best "Ruby way" to generate this sentence-like string.

Basically, the rules are:

* The class's constructor should accept a list of arguments that can be day
  numbers (see day number hash below), day abbreviations ('Mon', 'Tue', etc.),
  or the full names of the days ('Monday', 'Tuesday', etc.).
* If an invalid day id is included in the argument list, the constructor
  should raise an ArgumentError.
* The days should be sorted starting with Monday.
* Three or more consecutive days should be represented by listing the first
  day followed by a hyphen (-), followed by the last day of the range.
* Individual days and the above day ranges should be separated by commas.
* The class should number days (accepting Integers or Strings) as follows:
	    1:  Mon
	    2:  Tue
	    3:  Wed
	    4:  Thu
	    5:  Fri
	    6:  Sat
	    7:  Sun
* The class needs a method named #to_s that returns the day range string.
  Here are some example lists of days and their expected returned strings:
	    1,2,3,4,5,6,7:  Mon-Sun
	    1,2,3,6,7:      Mon-Wed, Sat, Sun
	    1,3,4,5,6:      Mon, Wed-Sat
	    2,3,4,6,7:      Tue-Thu, Sat, Sun
	    1,3,4,6,7:      Mon, Wed, Thu, Sat, Sun
	    7:              Sun
	    1,7:            Mon, Sun
	    1,8:            ArgumentError

Solution: 
I use the initialize methdo to do the input argument checking, it will raise argument error if
passing invalid arugments. 

Array#abbrev is used here so the code can create a lookup table for all possible abbreviations to the actual numbers.

DayRange#number_ranges starts the process by building an Array of Arrays with the days divided into groups of start and 
end days. Days that run in succession are grouped together and lone days appear as both the start and end. For example, 
the days 1, 2, 3, and 6 would be divided into `[[1, 3], [6, 6]]`.

vim-tex2text
=============

Problem
-------

You write your documents using Latex and Vim and everything is great.
However good the spell check and autocorrect in Vim is, though, grammar
mistakes slip by. 

You'd like to use another tool for this grammar checking, but the raw
Latex source is full of commands and the like. 

PDF to text or Word is plain miserable. 

This plugin looks to solve this. 


Solution
--------

The solution is to do some smart changes to the original source. 

The things that this plugin does is:

1. Remove figure and table environments. 
2. Remove chapter and section headings.
3. Replace all `\refs{}` with '1'
4. Remove all italicizing and bolding (`\textit{}` and `\textbf{}`)
5. Change Latex quotes (````''` ) to regular ole' '"'s
6. Change all `\cite{}`s to 'Paulus', I'll take the credit.
7. Replace inline equations, `\(a+b\)`, with a proper noun, Mitch
8. Remove equation-like environments (equation, array, multline...)
9. Remove all comments
10. When all of this is done, join all paragraph lines, removing double
   linefeeds.


Installation
------------

I would highly recommend getting comfortable with Vundle for
installation. Check it out. 


Usage
-----

Just use the mapping `<leader>gc` [g]rammar [c]heck. This will make a
text file in the same directory as the current buffer, with the suffix
-texto.txt. 

Inspriation
-----------

Well the inspiration for this came from working on my Ph.D. disseration.
If you haven't been fortunate to write one of these, it's long and prime
for grammatical errors. But I love vim and Latex. And I pay for
Grammarly. So this was a necessary consequence.









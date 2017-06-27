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
5. Remove `textsuperscript`s and `textsubscript`s
6. Change Latex quotes (````''` ) to regular ole' '"'s
7. Change all `\cite{}`s to 'Paulus', I'll take the credit.
8. Replace inline equations, `\(a+b\)`, with a proper noun, Mitch
9. Remove equation-like environments (equation, array, multline...)
10. Remove all comments
11. Remove all `\usepackage` lines
12. Change _pseudo_ degree sign `\(^{\circ}\)`'s to utf-8 ° sign.
13. Change `\(\pm\)` to 'plus or minus'
14. Smart formatting of itemized lists
15. When all of this is done, join all paragraph lines, removing double
   linefeeds.

The results are stored in directory `TransformedTexFiles` which will be in the
same directory as the original buffer. 


Installation
------------

I would highly recommend getting comfortable with
[Vundle](https://github.com/VundleVim/Vundle.vim) for installation.
Check it out. 


Usage
-----

Just use the mapping `<leader>ttt` [t]ex [t]o [t]ext. This will make a
text file in the directory `TransformedTexFiles` which will be in the
same directory as the original buffer. 

Inspriation
-----------

Well the inspiration for this came from working on my Ph.D. disseration.
If you haven't been fortunate to write one of these, it's long and prime
for grammatical errors. But I love vim and Latex. And I pay for
Grammarly. So this was a necessary consequence.


Hopefully to come
-----------------

Obviously this is a work in progress. I will be adding items as I come
across them. This is open-source, so feel free to make an issue and
contribute!











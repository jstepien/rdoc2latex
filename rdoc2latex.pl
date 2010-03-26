#!/usr/bin/env perl
# Copyright (c) 2010 Jan Stępień
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
use warnings;
use strict;
print '\documentclass[a4paper]{article}
\usepackage[utf8]{inputenc}
\usepackage{a4wide}
\begin{document}';

my $verbatim = 0;
while (<>) {
	if (/^\ \ /) {
		print '\begin{verbatim}' if ($verbatim == 0);
		$verbatim = 1;
	} else {
		s/^===(.*)/\\subsubsection{$1}/;
		s/^==(.*)/\\subsection{$1}/;
		s/^=(.*)/\\section{$1}/;
		s/\+(\S+)\+/\\texttt{$1}/g;
		s/#/\\#/g;
		s/\$/\\\$/g;
		s/_/\\_/g;
		s/&/\\&/g;
		$verbatim = 2 if ($verbatim == 1);
	}
	print;
	(print '\end{verbatim}' and $verbatim = 0) if $verbatim == 2;
}
print "\\end{document}\n";

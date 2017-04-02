#!/usr/bin/perl
#
# License
# Copyright (c) 2017 Ng Chiang Lin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# This code is provided and to be used for educational purpose only.
# Computer misuse is a serious crime in Singapore and other
# countries, punishable by law.
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# This code is provided and to be used for educational purpose only.
# Simple perl script to extract
# machine instructions from
# objdump -d output
#
# Ng Chiang Lin
# April 2017
#

use strict;
use warnings;

if(scalar(@ARGV) != 1)
{
   die "Usage: ./extractshellcode.pl <objdump -d output file>\n";
}

my $filename = $ARGV[0];
open(my $ifh, "<$filename") or die "Cannot open file $filename, $!";

my $codestring = "static unsigned char shellcode[]={\n"; 
my $maxlinelen = 10; 
my $cnt = 1; 
my $firstline = 1; 

while (my $line = <$ifh>)
{
   $line =~ s/^\s+|\s+$//g;
   my @arr = split('\t', $line);
   if(scalar(@arr) >= 2)
   {
      $line= $arr[1]; 
      $line =~ s/^\s+|\s+$//g;
      my @int = split('\s', $line);
    
      foreach my $intr (@int)
      {
         $intr = "'\\x" . $intr . "\',";
            
         if($cnt == 10)
         {
             $codestring = $codestring . $intr . "\n";
             $cnt = 0; 
         } 
         else
         {
             $codestring = $codestring . $intr; 
         }

         $cnt++;
      }

   }   
}

close($ifh);
chop $codestring;
$codestring = $codestring . "};\n";

print $codestring; 

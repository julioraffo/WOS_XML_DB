<?php
// xml splitter
if (!isset($argv[1]) or !isset($argv[2]) or !isset($argv[3]) or !isset($argv[4]) )
  die ("\n
splitxml v1.0 : by Julio Raffo \n
==============================================================\n\n
Description: Splits one large XML file to  \n\n
multiple X records XML files based on a given root node  \n\n
Usage: php splitxmlfile <targetdir> <targetfile> <targetnode> <nodes_per_file> [header] \n\n
Example: php splitxmlfile X:\Mydir MyXML.xml Y:\MySplitFolder Mynode 10000 \n\n
\n\n");
  else
  {
  $dir = $argv[1]; 
  $file = $argv[2];
  $tag = $argv[3];
  $tagsize = strlen($tag);
  $maxbuf = $argv[4];
  if (isset($argv[5]) and $argv[5]=='header') $headflag=true;
  $headflag=false;   
  } 

if (is_file("$dir\\$file")) {
  if (substr($file,-3,3)=="xml") {
    echo "Starting processing for: $file\n";
    $newfilestub = substr($file,0,-4);
    $largexml = fopen("$dir\\$file", "r");
    $buffer = '';
    $n=0;
    $counter=0;
    $header='';
    while(!feof($largexml)) {
     $rawline = fgets($largexml, 4096);
     $line = trim($rawline);
     if ($headflag and $header=='') {
      $header=$line;
      $buffer=$header;
     }
     else { 
      if ($pos=strpos($line, $tag) !== false) {
       $counter++;
       if ($counter>=$maxbuf) {
        $left = substr($line, 0, $pos+$tagsize);
        $buffer .= "\n$left";
        $right = substr($line, $pos+$tagsize);
        $n ++;
        $newfile = $dir."\\".$newfilestub."_".$n.".xml";
        echo "Saving $newfile\n";
        file_put_contents($newfile,$buffer);
        if ($headflag) $buffer = "$header\n".trim($right);
        else $buffer = trim($right);
        $counter=0;
       }
       else $buffer .= "\n$line";
      }
      else $buffer .= "\n$line";
     }
    }
    // remaining cases
    if ($buffer!=="") {
     $n ++;
     $newfile = $dir."\\".$newfilestub."_".$n.".xml";
     echo "Saving $newfile\n";
     file_put_contents($newfile,$buffer);
    }
    fclose($largexml);
  }
}
?>
PHP script to split XML files
=============================

PHP script to split large WOS XML files into smaller ones based on the closing tag and desired number of records.
New files are saved in the same path than the original file and named with the original name as stem.

Run from PHP client  command prompt

- php splitxmlfile.php <Filename.xml\> "</closingtag\>" <Number_of_records_per_file\>

Example:

- php splitxmlfile.php C:\\tmp\\2012_DU WR_2012_20170219195649_DU_0001.xml "</REC\>" 10000

Results in something like:

- C:\\tmp\\2012_DU WR_2012_20170219195649_DU_0001_1.xml
- C:\\tmp\\2012_DU WR_2012_20170219195649_DU_0001_2.xml
- C:\\tmp\\2012_DU WR_2012_20170219195649_DU_0001_3.xml
- ...
- C:\\tmp\\2012_DU WR_2012_20170219195649_DU_0001_20.xml

SQL script to load XMLs to server
=================================

Loading is relatively fast. To create loading SQL scripts automatically use Excel file or Stata code in this folder.

Basic syntax needs:
------------------
1) Filename to be stored in wos.rawXMLs table
(Note: this is to be able to replace duplicates when updates are received;
Suggested syntax use original name from Clarivate in uppercase and remove trailing ".xml")

2) UID (automatically extracted from each XML)

3) Date & Time stamp (automatically generated during load)

4) complete XML for each record

Suggested syntax:
----------------
```mysql
set @file:='YOUR_XML_NAME_HERE';
Load data local infile '<PATH>/your_xml_name.xml'  
IGNORE INTO TABLE wos.rawXMLs
fields terminated by '$$$$$$$$' escaped by ''
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Thomson Reuters">'
terminated by '</REC>' (@line) set xml=@line,     
UID=ExtractValue(@line,'//UID'), 	 
file=@file,
loaded = CURRENT_TIMESTAMP;
commit;
```
Notes:
-----
- `fields terminated by '$$$$$$$$' escaped by ''` is to avoid default truncation by TABs (i.e. "\\t")
- `lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Thomson Reuters">'` can be handy to avoid records not correctly closed by </REC\>. If fails try instead:
`lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate">'`

Concrete example:
----------------
```mysql
set @file:='WR_2012_20170219194154_DU_0001';
LOAD data LOCAL INFILE 'C:/tmp/2012_DU/WR_2012_20170219194154_DU_0001_1.xml'
IGNORE INTO TABLE wos.rawXMLs fields terminated by '$$$$$$$$' escaped by ''
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Thomson Reuters">'
terminated by '</REC>' (@line)
set xml=@line,
UID=ExtractValue(@line,'//UID'),
file=@file,
loaded = CURRENT_TIMESTAMP;
commit;
```

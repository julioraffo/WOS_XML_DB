SQL script to load XMLs to server
=================================

Loading is relatively fast. To create loading SQL scripts automatically use Excel file or Stata code in this folder. 

Basic syntax needs: 

1) the filename to be stored in wos.rawXMLs table 
(Note: this is to be able to replace when updates are received; 
Suggested syntax use original name from Clarivate in uppercase and remove trailing ".xml")
2) UID (automatically extracted from each XML)
3) Date & Time stamp (automatically generated during load)
4) complete XML

Suggested syntax:
----------------
set @file:='YOUR_XML_NAME_HERE';  -- (e.g. set @file:='WR_2012_20170219194154_DU_0001';)
Load data local infile '<PATH>/your_xml_name.xml' -- (e.g. LOAD data LOCAL INFILE 'C:/tmp/2012_DU/WR_2012_20170219194154_DU_0001_1.xml') 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' -- Note: This is to avoid default truncation by TABs (i.e. \t)
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Thomson Reuters">' 
-- (if fails try instead: lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">') 
terminated by '</REC>' (@line) set xml=@line,     
UID=ExtractValue(@line,'//UID'), 	 
file=@file, 
loaded = CURRENT_TIMESTAMP; 
commit; 

Concrete example:
----------------
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

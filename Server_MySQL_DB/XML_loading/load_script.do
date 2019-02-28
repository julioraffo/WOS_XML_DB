// change these two parameters only: 

loc mydir "C:/tmp/split"
// loc dsn "localhost"
loc dsn "wos"

log using "load_status_log.txt", replace text
di c(current_date) " " c(current_time)
cd "`mydir'"
local list : dir . files "*.xml"
di `"`list'"'
foreach file of loc list {
loc curstub=ustrregexrf("`file'", "_[0-9]+.xml", ".xml",1) 
loc sql `"LOAD data LOCAL INFILE '`mydir'/`file'' IGNORE INTO TABLE wos.rawXMLs lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Thomson Reuters\">' terminated by '</REC>' (@line) set xml=@line, UID=ExtractValue(@line,'//UID'), file='`curstub'', loaded = CURRENT_TIMESTAMP "'
di "FILE: `mydir'/'file'"
di "STUB: `curstub'"
di `"SQL: `sql'"'
di c(current_date) " " c(current_time)
di `"Loading to `dsn'..."'
odbc exec(`"`sql'"'), dsn("`dsn'")
odbc exec("commit"), dsn("`dsn'")
di `"...finished!"'
}
di c(current_date) " " c(current_time)
log close

// Generates SQL file instead: 
loc mydir "C:/tmp/split"
cd "`mydir'"
local list : dir . files "*.xml"
di `"`list'"'
set linesize 255
qui log using "load_tables_auto.sql", replace text  
qui foreach file of loc list {
qui loc curstub=upper(ustrregexrf("`file'", "_[0-9]+.xml", "",1))
n di `"LOAD data LOCAL INFILE '`mydir'/`file'' "'
n di `"IGNORE INTO TABLE wos.rawXMLs "'
n di `"fields terminated by '$$$$$$$$' escaped by '' "'
n di `"lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' "'
// n di `"lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Thomson Reuters\">' "'
n di `"terminated by '</REC>' "'
n di `"(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), "'
n di `"file='`curstub'', loaded = CURRENT_TIMESTAMP ; commit;"'
}
qui log close

/*
// Generates list of xml files : 
*loc mydir "C:/tmp/split"
*loc mydir "C:/tmp/2012_DU"
loc mydir "C:/tmp/split2017
di c(current_date) " " c(current_time)
cd "`mydir'"
local list : dir . files "*.xml"
di `"`list'"'
loc oldstub=""
foreach file of loc list {
loc curstub=upper(ustrregexrf("`file'", "_[0-9]+.xml", ".xml",1)) 
di `"LOAD data LOCAL INFILE '`mydir'/`file'' IGNORE INTO TABLE wos.rawXMLs fields terminated by '$$$$$$$$' escaped by '' lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Thomson Reuters\">' terminated by '</REC>' (@line) set xml=@line, UID=ExtractValue(@line,'//UID'), file='`curstub'', loaded = CURRENT_TIMESTAMP "'
if ("`oldstub'"!="`curstub'") di "`curstub'"
loc oldstub="`curstub'"
}



*/


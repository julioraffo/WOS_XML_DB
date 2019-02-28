LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_1.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_10.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_11.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_2.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_3.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_4.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_5.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_6.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_7.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_8.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0001_9.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0001', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_1.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_10.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_11.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_2.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_3.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_4.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_5.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_6.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_7.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_8.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0002_9.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0002', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0003_1.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0003', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0003_10.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0003', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0003_2.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0003', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0003_3.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0003', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0003_4.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0003', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0003_5.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0003', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0003_6.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0003', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0003_7.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0003', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0003_8.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0003', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0003_9.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0003', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0004_1.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0004', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0004_2.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0004', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0004_3.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0004', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0004_4.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0004', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0004_5.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0004', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0004_6.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0004', loaded = CURRENT_TIMESTAMP ; commit;
LOAD data LOCAL INFILE 'C:/tmp/split2017/wr_2017_20180509131811_du_0004_7.xml' 
IGNORE INTO TABLE wos.rawXMLs 
fields terminated by '$$$$$$$$' escaped by '' 
lines starting by '<REC r_id_disclaimer="ResearcherID data provided by Clarivate Analytics">' 
terminated by '</REC>' 
(@line) set xml=@line, UID=ExtractValue(@line,'//UID'), 
file='WR_2017_20180509131811_DU_0004', loaded = CURRENT_TIMESTAMP ; commit;

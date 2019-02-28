-- Tables WOS 200s
-- 
ALTER TABLE wos.w111_references ADD INDEX(cited_UID); commit;

-- w211 CITATIONS

drop table if exists wos.w211_citations; commit;
create table wos.w211_citations (
  citing_id int(11) NOT NULL DEFAULT '0',
  cited_id int(11) NOT NULL DEFAULT '0',
  cit_lag decimal(10,4) DEFAULT NULL,
index(citing_id), index(cited_id)); commit; 

i

select * from wos.w211_citations limit 1000;
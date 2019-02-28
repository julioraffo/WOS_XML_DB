use wos;
-- stats -------------------------------------------------------------
-- 1) All
select * from wos.table_status ;
-- 2) Unfinished tables
select * from wos.table_status t where t.ratio<100;
-- 3) missing records & Unfinished tables
select t.benchmark-t.rows, t.* from wos.table_status t ;
-- 4) missing records
select CURRENT_TIMESTAMP, t.benchmark-t.rows, t.* from wos.table_status t  where t.benchmark>t.rows;

-- --------------------------------------------------------------------
-- Drop and Re-Create Table
drop table if exists wos.table_status ;
CREATE TABLE wos.table_status 
 SELECT table_name, 0 as rows, 0 as benchmark, 100.00 as ratio 
  FROM information_schema.tables 
  WHERE table_schema = 'wos' and (table_name like 'w%' or table_name like 'raw%' or 'UIDs'); commit;
-- --------------------------------------------------------------------
insert into wos.table_status set table_name='UIDs'; commit; 
insert into wos.table_status set table_name='w211_citations'; commit; 


-- UPDATE ONLY BENCHMARK & RATIO
set @b:=27726805; -- based on WOS file counts
-- table rawXMLs
update wos.table_status s set s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='rawXMLs'; commit; 
--  table UIDs
update wos.table_status s set s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='UIDs'; commit; 

-- w100
set @b:=(select t.benchmark from wos.table_status t where t.table_name='UIDs' );
update wos.table_status s set s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w100_counts'; commit; 
-- w101
set @b:=(select benchmark from wos.table_status where table_name='UIDs'); update wos.table_status s set s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w101_summary'; commit; 
-- w122
set @b:=(select benchmark from wos.table_status where table_name='UIDs'); update wos.table_status s set s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w122_item'; commit; 
-- w124
set @b:=(select benchmark from wos.table_status where table_name='UIDs'); update wos.table_status s set s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w124_reprint_addr'; commit; 
-- w128
set @b:=(select benchmark from wos.table_status where table_name='UIDs'); update wos.table_status s set s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w128_reviewed_work'; commit; 
-- w131
set @b:=(select benchmark from wos.table_status where table_name='UIDs'); update wos.table_status s set s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w131_ic_related'; commit; 
-- w102
update wos.table_status s set s.benchmark=(select sum(w0.edition_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w102_editions'; commit; 
-- w103
update wos.table_status s set s.benchmark=(select sum(w0.titles_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w103_titles'; commit; 
-- w104
update wos.table_status s set s.benchmark=(select sum(w0.names_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w104_names'; commit; 
-- w105
update wos.table_status s set s.benchmark=(select sum(w0.doctypes_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w105_doctypes'; commit; 
-- w106
update wos.table_status s set s.benchmark=(select sum(w0.conferences_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w106_conferences'; commit; 
-- w107
update wos.table_status s set s.benchmark=(select sum(w0.publishers_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w107_publishers'; commit; 
-- w108
update wos.table_status s set s.benchmark=(select sum(w0.languages_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w108_languages'; commit; 
-- w109
update wos.table_status s set s.benchmark=(select sum(w0.normalized_languages_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w109_normalized_languages'; commit;-- w110
update wos.table_status s set s.benchmark=(select sum(w0.normalized_doctypes_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w110_normalized_doctypes'; commit; 
-- w111
update wos.table_status s set s.benchmark=(select sum(w0.references_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w111_references'; commit; 
-- w112
update wos.table_status s set s.benchmark=(select sum(w0.headings_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w112_headings'; commit; 
-- w113
update wos.table_status s set s.benchmark=(select sum(w0.subheadings_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w113_subheadings'; commit; 
-- w114
update wos.table_status s set s.benchmark=(select sum(w0.subjects_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w114_subjects'; commit; 
-- w115
update wos.table_status s set s.benchmark=(select sum(w0.keywords_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w115_keywords'; commit; 
-- w116
update wos.table_status s set s.benchmark=(select sum(w0.abstracts_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w116_abstracts'; commit; 
-- w117
update wos.table_status s set s.benchmark=(select sum(w0.grants_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w117_grants'; commit; 
-- w118
update wos.table_status s set s.benchmark=(select sum(w0.addresses_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w118_addresses'; commit; 
-- w129
update wos.table_status s set s.benchmark=(select sum(w0.contributors_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w129_contributors'; commit; 
-- w130
update wos.table_status s set s.benchmark=(select sum(w0.identifiers_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w130_identifiers'; commit; 
-- w106s
update wos.table_status s set s.benchmark=(select sum(w0.conf_sponsors_Q) from wos.w106_conferences w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w106_conf_sponsors'; commit; 
-- w117s
update wos.table_status s set s.benchmark=(select sum(w0.grant_ids_Q) from wos.w117_grants w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w117_grants_ids'; commit; 
-- w119
update wos.table_status s set s.benchmark=(select sum(w0.addr_org_Q) from wos.w118_addresses w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w119_addr_org'; commit; 
-- w120
update wos.table_status s set s.benchmark=(select sum(w0.addr_suborg_Q) from wos.w118_addresses w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w120_addr_suborg'; commit; 
-- w121
update wos.table_status s set s.benchmark=(select sum(w0.addr_names_Q) from wos.w118_addresses w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w121_addr_names'; commit; 
-- w123
update wos.table_status s set s.benchmark=(select sum(w0.keywords_Q) from wos.w122_item w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w123_item_keywords'; commit; 
-- w125
update wos.table_status s set s.benchmark=(select sum(w0.org_Q) from wos.w124_reprint_addr w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w125_reprint_org'; commit; 
-- w126
update wos.table_status s set s.benchmark=(select sum(w0.suborg_Q) from wos.w124_reprint_addr w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w126_reprint_suborg'; commit; 
-- w127
update wos.table_status s set s.benchmark=(select sum(w0.names_Q) from wos.w124_reprint_addr w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w127_reprint_addr_name'; commit; 
-- w128s
update wos.table_status s set s.benchmark=(select sum(w0.rw_authors_Q) from wos.w128_reviewed_work w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w128_rw_authors'; commit; 

-- w211
set @b:=(select count(*) from wos.w111_references w11 inner join wos.UIDs u on w11.cited_UID=u.UID);
update wos.table_status s set s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w211_citations'; commit; 
 select @b;

-- --------------------------------------------------------------------
-- UPDATE EVERYTHING
set @b:=27726805; -- based on WOS file counts
-- table rawXMLs
set @raw:=(SELECT count(*) FROM wos.rawXMLs); update wos.table_status s set s.rows=@raw, s.benchmark=@b, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='rawXMLs'; commit; 
--  table UIDs
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.UIDs), s.benchmark=@b, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='UIDs'; commit; 
-- update wos.table_status s set s.rows=10619572, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='UIDs'; commit; 
-- w100
set @b:=(select t.benchmark from wos.table_status t where t.table_name='UIDs' );
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w100_counts), s.benchmark=@b, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w100_counts'; commit; 
-- w101
set @b:=(select t.benchmark from wos.table_status t where t.table_name='UIDs' );
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w101_summary), s.benchmark=@b, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w101_summary'; commit; 
-- w122
set @b:=(select t.benchmark from wos.table_status t where t.table_name='UIDs' );
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w122_item), s.benchmark=@b, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w122_item'; commit; 
-- w124
set @b:=(select t.benchmark from wos.table_status t where t.table_name='UIDs' );
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w124_reprint_addr), s.benchmark=@b, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w124_reprint_addr'; commit; 
-- w128
set @b:=(select t.benchmark from wos.table_status t where t.table_name='UIDs' );
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w128_reviewed_work), s.benchmark=@b, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w128_reviewed_work'; commit; 
-- w131
set @b:=(select t.benchmark from wos.table_status t where t.table_name='UIDs' );
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w131_ic_related), s.benchmark=@b, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w131_ic_related'; commit; 
-- w102
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w102_editions), s.benchmark=(select sum(w0.edition_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w102_editions'; commit; 
-- w103
set @r:=(SELECT count(*) FROM wos.w103_titles); set @b:=(select sum(w0.titles_Q) from wos.w100_counts w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w103_titles'; commit; 
-- w104
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w104_names), s.benchmark=(select sum(w0.names_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w104_names'; commit; 
-- w105
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w105_doctypes), s.benchmark=(select sum(w0.doctypes_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w105_doctypes'; commit; 
-- w106
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w106_conferences), s.benchmark=(select sum(w0.conferences_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w106_conferences'; commit; 
-- w107
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w107_publishers), s.benchmark=(select sum(w0.publishers_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w107_publishers'; commit; 
-- w108
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w108_languages), s.benchmark=(select sum(w0.languages_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w108_languages'; commit; 
-- w109
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w109_normalized_languages), s.benchmark=(select sum(w0.normalized_languages_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w109_normalized_languages'; commit; 
-- w110
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w110_normalized_doctypes), s.benchmark=(select sum(w0.normalized_doctypes_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w110_normalized_doctypes'; commit; 
-- w111
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w111_references), s.benchmark=(select sum(w0.references_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w111_references'; commit; 
-- w112
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w112_headings), s.benchmark=(select sum(w0.headings_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w112_headings'; commit; 
-- w113
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w113_subheadings), s.benchmark=(select sum(w0.subheadings_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w113_subheadings'; commit; 
-- w114
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w114_subjects), s.benchmark=(select sum(w0.subjects_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w114_subjects'; commit; 
-- w115
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w115_keywords), s.benchmark=(select sum(w0.keywords_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w115_keywords'; commit; 
-- w116
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w116_abstracts), s.benchmark=(select sum(w0.abstracts_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w116_abstracts'; commit; 
-- w117
update wos.table_status s set s.rows=(SELECT count(*) FROM wos.w117_grants), s.benchmark=(select sum(w0.grants_Q) from wos.w100_counts w0), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w117_grants'; commit; 
-- w118
set @r:=(SELECT count(*) FROM wos.w118_addresses); set @b:=(select sum(w0.addresses_Q) from wos.w100_counts w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w118_addresses'; commit; 
-- w129
set @r:=(SELECT count(*) FROM wos.w129_contributors); set @b:=(select sum(w0.contributors_Q) from wos.w100_counts w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w129_contributors'; commit; 
-- w130
set @r:=(SELECT count(*) FROM wos.w130_identifiers); set @b:=(select sum(w0.identifiers_Q) from wos.w100_counts w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w130_identifiers'; commit; 
-- w106s
set @r:=(SELECT count(*) FROM wos.w106_conf_sponsors); set @b:=(select sum(w0.conf_sponsors_Q) from wos.w106_conferences w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w106_conf_sponsors'; commit; 
-- w117s
set @r:=(SELECT count(*) FROM wos.w117_grants_ids); set @b:=(select sum(w0.grant_ids_Q) from wos.w117_grants w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w117_grants_ids'; commit; 
-- w119
set @r:=(SELECT count(*) FROM wos.w119_addr_org); set @b:=(select sum(w0.addr_org_Q) from wos.w118_addresses w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w119_addr_org'; commit; 
-- w120
set @r:=(SELECT count(*) FROM wos.w120_addr_suborg); set @b:=(select sum(w0.addr_suborg_Q) from wos.w118_addresses w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w120_addr_suborg'; commit; 
-- w121
set @r:=(SELECT count(*) FROM wos.w121_addr_names); set @b:=(select sum(w0.addr_names_Q) from wos.w118_addresses w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w121_addr_names'; commit; 
-- w123
set @r:=(SELECT count(*) FROM wos.w123_item_keywords); set @b:=(select sum(w0.keywords_Q) from wos.w122_item w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w123_item_keywords'; commit; 
-- w125
set @r:=(SELECT count(*) FROM wos.w125_reprint_org); set @b:=(select sum(w0.org_Q) from wos.w124_reprint_addr w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w125_reprint_org'; commit; 
-- w126
set @r:=(SELECT count(*) FROM wos.w126_reprint_suborg); set @b:=(select sum(w0.suborg_Q) from wos.w124_reprint_addr w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w126_reprint_suborg'; commit; 
-- w127
set @r:=(SELECT count(*) FROM wos.w127_reprint_addr_name); set @b:=(select sum(w0.names_Q) from wos.w124_reprint_addr w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w127_reprint_addr_name'; commit; 
-- w128
set @r:=(SELECT count(*) FROM wos.w128_rw_authors); set @b:=(select sum(w0.rw_authors_Q) from wos.w128_reviewed_work w0); update wos.table_status s set s.rows=(@r), s.benchmark=(@b), s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w128_rw_authors'; commit; 




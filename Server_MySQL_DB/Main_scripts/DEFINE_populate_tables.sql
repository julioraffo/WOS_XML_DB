use wos;
-- 100) Counts
drop procedure if exists myloop100;
delimiter $
create procedure myloop100(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt from "create temporary table wos.myids (index(id)) select x.id from wos.rawXMLs x left join wos.w100_counts w0 using(id) where w0.id is null limit ? ;" ;
 execute mystmt using @l;
 DEALLOCATE PREPARE mystmt;
 set @i:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @i <= mymax DO
  prepare mystmt2 from " insert ignore into wos.w100_counts select x.id, ExtractValue(x.xml,'count(//static_data/summary/EWUID/edition)')+0 as edition_Q, ExtractValue(x.xml,'//static_data/summary/titles/@count')+0 as titles_Q, ExtractValue(x.xml,'//static_data/summary/names/@count')+0 as names_Q, ExtractValue(x.xml,'//static_data/summary/doctypes/@count')+0 as doctypes_Q, ExtractValue(x.xml,'//static_data/summary/conferences/@count')+0 as conferences_Q, ExtractValue(x.xml,'//static_data/summary/publishers/publisher/names/@count')+0 as publishers_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/languages/@count')+0 as languages_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/normalized_languages/@count')+0 as normalized_languages_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/normalized_doctypes/@count')+0 as normalized_doctypes_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/@count')+0 as references_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/category_info/headings/@count')+0 as headings_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/category_info/subheadings/@count')+0 as subheadings_Q,  ExtractValue(x.xml,'//static_data/fullrecord_metadata/category_info/subjects/@count')+0 as subjects_Q,  ExtractValue(x.xml,'//static_data/fullrecord_metadata/keywords/@count')+0 as keywords_Q, 	ExtractValue(x.xml,'//static_data/fullrecord_metadata/abstracts/@count')+0 as abstracts_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/fund_ack/grants/@count')+0 as grants_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/@count')+0 as addresses_Q, ExtractValue(x.xml,'//static_data/contributors/@count')+0 as contributors_Q, ExtractValue(x.xml,'count(//dynamic_data/cluster_related/identifiers/identifier)')+0 as indentifier_Q from wos.rawXMLs x inner join (select * from wos.myids limit ? , ?) w0 using(id);" ;
   execute mystmt2 using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt2;
   SET @i = @i + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w100_counts);
   update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w100_counts'; commit; 
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- 101) summary (~30 mins every 500k)
drop procedure if exists myloop101;
delimiter $
create procedure myloop101(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt101 from "create temporary table wos.myids (index(id)) select x.id from wos.rawXMLs x left join wos.w101_summary w0 using(id) where w0.id is null limit ? ;" ;
 execute mystmt101 using @l;
 DEALLOCATE PREPARE mystmt101;
 set @i:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @i <= mymax DO
  prepare mystmt101b from " insert ignore into wos.w101_summary select x.id, ExtractValue(x.xml,'//static_data/summary/EWUID/WUID/@coll_id') as WUID, ExtractValue(x.xml,'//static_data/summary/pub_info/@coverdate') as coverdate, ExtractValue(x.xml,'//static_data/summary/pub_info/@has_abstract') as has_abstract,  ExtractValue(x.xml,'//static_data/summary/pub_info/@issue') as issue, ExtractValue(x.xml,'//static_data/summary/pub_info/@part_no') as part_no, ExtractValue(x.xml,'//static_data/summary/pub_info/@pubmonth') as pubmonth, ExtractValue(x.xml,'//static_data/summary/pub_info/@pubtype') as pubtype, ExtractValue(x.xml,'//static_data/summary/pub_info/@pubyear') as pubyear, ExtractValue(x.xml,'//static_data/summary/pub_info/@sortdate') as sortdate, ExtractValue(x.xml,'//static_data/summary/pub_info/@special_issue') as special_issue, ExtractValue(x.xml,'//static_data/summary/pub_info/@supplement') as supplement, ExtractValue(x.xml,'//static_data/summary/pub_info/@vol') as vol, ExtractValue(x.xml,'//static_data/summary/pub_info/page/@begin') as page_begin, ExtractValue(x.xml,'//static_data/summary/pub_info/page/@end') as page_end, ExtractValue(x.xml,'//static_data/summary/pub_info/page/@page_count') as page_count, ExtractValue(x.xml,'//static_data/summary/pub_info/page') as pages from wos.rawXMLs x inner join (select * from wos.myids limit ? , ?) w0 using(id);" ;
   execute mystmt101b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt101b;
   SET @i = @i + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w101_summary);
   update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w101_summary'; commit; 
 END WHILE;
 drop temporary table if exists wos.myids;
END $
delimiter ;


-- table w102_editions
drop procedure if exists myloop102;
delimiter $
create procedure myloop102(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt102 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w102_editions w using(id) where w0.edition_Q>0 and w.id is null limit ? ;" ;
 execute mystmt102 using @l;
 DEALLOCATE PREPARE mystmt102;
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt102b from "insert ignore into wos.w102_editions select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/summary/EWUID/edition[$@i]/@value') from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join wos.rawXMLs x on x.id=t.id inner join wos.num n on w0.edition_Q>=n.seq where w0.edition_Q>0;" ;
   execute mystmt102b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt102b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w102_editions); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w102_editions'; commit; 
 END WHILE;
 drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w103_titles
drop procedure if exists myloop103;
delimiter $
create procedure myloop103(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt103 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w103_titles w using(id) where w0.titles_Q>0 and w.id is null limit ? ;" ;
 execute mystmt103 using @l;
 DEALLOCATE PREPARE mystmt103;
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt103b from "insert ignore into wos.w103_titles select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/summary/titles/title[$@i]/@translated'), ExtractValue(x.xml,'//static_data/summary/titles/title[$@i]/@type'), ExtractValue(x.xml,'//static_data/summary/titles/title[$@i]') from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.titles_Q>=n.seq where w0.titles_Q>0;" ;
   execute mystmt103b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt103b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
  set @c:=(SELECT count(*) FROM wos.w103_titles); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w103_titles'; commit; 
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w103_titles (optimized)
drop procedure if exists myloop103bis;
delimiter $
create procedure myloop103bis(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt103_2 from "create temporary table wos.myids (index(id), index(titles_Q)) select w0.id, w0.titles_Q from wos.w100_counts w0 left join wos.w103_titles w using(id) where w0.titles_Q>0 and w.id is null limit ? ;" ;
 execute mystmt103_2 using @l;
 DEALLOCATE PREPARE mystmt103_2;
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt103_2b from "insert ignore into wos.w103_titles select t.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/summary/titles/title[$@i]/@translated'), ExtractValue(x.xml,'//static_data/summary/titles/title[$@i]/@type'), ExtractValue(x.xml,'//static_data/summary/titles/title[$@i]') from (select * from wos.myids limit ? , ?) t inner join rawXMLs x on x.id=t.id inner join wos.num n on t.titles_Q>=n.seq;" ;
   execute mystmt103_2b using @j, @b;
   commit;
   DEALLOCATE PREPARE mystmt103_2b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
  set @c:=(SELECT count(*) FROM wos.w103_titles); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w103_titles'; commit; 
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w104_names
drop procedure if exists myloop104;
delimiter $
create procedure myloop104(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt104 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w104_names w using(id) where w0.names_Q>0 and w.id is null limit ? ;" ;
 execute mystmt104 using @l;
 DEALLOCATE PREPARE mystmt104;
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt104b from "insert ignore into wos.w104_names select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/@addr_no'), ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/@dais_id') as dais_id,  ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/@orcid_id_tr') as orcid_id_tr, ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/@r_id') as r_id, ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/@r_id_tr') as r_id_tr, ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/@reprint'), ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/@role'), ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/@seq_no')+0, ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/display_name'), ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/full_name'), ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/wos_standard'), ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/first_name'), ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/last_name'), ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/suffix') as suffix, ExtractValue(x.xml,'//static_data/summary/names/name[$@i]/email_addr') from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.names_Q>=n.seq where w0.names_Q>0;" ;
   execute mystmt104b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt104b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w104_names); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w104_names'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w105_doctypes
drop procedure if exists myloop105;
delimiter $
create procedure myloop105(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt105 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w105_doctypes w using(id) where w0.doctypes_Q>0 and w.id is null limit ? ;" ;
 execute mystmt105 using @l;
 DEALLOCATE PREPARE mystmt105; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt105b from "insert ignore into wos.w105_doctypes select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/summary/doctypes/doctype[$@i]') from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.doctypes_Q>=n.seq where w0.doctypes_Q>0;" ;
   execute mystmt105b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt105b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w105_doctypes); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w105_doctypes'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;


-- table w106_conferences
drop procedure if exists myloop106;
delimiter $
create procedure myloop106(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt106 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w106_conferences w on w.id=w0.id where w0.conferences_Q>0 and w.id is null limit ? ;" ;
 execute mystmt106 using @l;
 DEALLOCATE PREPARE mystmt106; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt106b from "insert ignore into wos.w106_conferences select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/@conf_id')+0 as conf_id, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_infos/@count')+0 as conf_infos_Q, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_infos/conf_info') as conf_info, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_titles/@count')+0 as conf_titles_Q, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_titles/conf_title') as conf_title, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_dates/@count')+0 as conf_dates_Q, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_dates/conf_date/@conf_start') as conf_date_start, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_dates/conf_date/@conf_end') as  conf_date_end , ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_dates/conf_date') as conf_date, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_locations/@count')+0 as conf_locations_Q, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_locations/conf_location/conf_host') as conf_host, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_locations/conf_location/conf_city') as conf_city, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/conf_locations/conf_location/conf_state') as conf_state, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@i]/sponsors/@count')+0 as conf_sponsors_Q from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.conferences_Q>=n.seq where w0.conferences_Q>0;" ;
   execute mystmt106b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt106b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w106_conferences); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w106_conferences'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;


-- wos.w106_conf_sponsors
drop procedure if exists myloop106s;
delimiter $
create procedure myloop106s(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt106s from "create temporary table wos.myids (index(id)) select distinct w0.id from wos.w106_conferences w0 left join wos.w106_conf_sponsors w on w.id=w0.id where w0.conf_sponsors_Q>0 and w.id is null limit ? ;" ;
 execute mystmt106s using @l;
 DEALLOCATE PREPARE mystmt106s; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt106sb from "insert ignore into wos.w106_conf_sponsors select w0.id, @m:=w0.conference_seq, @i:=n.seq, ExtractValue(x.xml,'//static_data/summary/conferences/conference[$@m]/sponsors/sponsor[$@i]') as conf_sponsors from (select * from wos.myids limit ? , ?) t inner join wos.w106_conferences w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.conf_sponsors_Q>=n.seq where w0.conf_sponsors_Q>0;" ;
   execute mystmt106sb using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt106sb;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w106_conf_sponsors); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w106_conf_sponsors'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;


-- table w107_publishers
drop procedure if exists myloop107;
delimiter $
create procedure myloop107(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt107 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w107_publishers w on w.id=w0.id where w0.publishers_Q>0 and w.id is null limit ? ;" ;
 execute mystmt107 using @l;
 DEALLOCATE PREPARE mystmt107; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt107b from "insert ignore into wos.w107_publishers select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/summary/publishers/publisher/address_spec/@addr_no')+0 as pub_addr_no, ExtractValue(x.xml,'//static_data/summary/publishers/publisher/address_spec/full_address') as pub_full_address, ExtractValue(x.xml,'//static_data/summary/publishers/publisher/address_spec/city') as pub_city, ExtractValue(x.xml,'//static_data/summary/publishers/publisher/names/name[$@i]/@addr_no') as pub_n_addr_no, ExtractValue(x.xml,'//static_data/summary/publishers/publisher/names/name[$@i]/@role') as pub_role, ExtractValue(x.xml,'//static_data/summary/publishers/publisher/names/name[$@i]/@seq_no') as pub_seq_no, ExtractValue(x.xml,'//static_data/summary/publishers/publisher/names/name[$@i]/display_name') as pub_display_name, ExtractValue(x.xml,'//static_data/summary/publishers/publisher/names/name[$@i]/full_name') as pub_full_name from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.publishers_Q>=n.seq where w0.publishers_Q>0;" ;
   execute mystmt107b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt107b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w107_publishers); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w107_publishers'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;


-- table w108_languages
drop procedure if exists myloop108;
delimiter $
create procedure myloop108(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt108 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w108_languages w on w.id=w0.id where w0.languages_Q>0 and w.id is null limit ? ;" ;
 execute mystmt108 using @l;
 DEALLOCATE PREPARE mystmt108; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt108b from "insert ignore into wos.w108_languages select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/languages/language[$@i]/@type'), ExtractValue(x.xml,'//static_data/fullrecord_metadata/languages/language[$@i]')  from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.languages_Q>=n.seq where w0.languages_Q>0;" ;
   execute mystmt108b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt108b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w108_languages); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w108_languages'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  

-- table w109_normalized_languages
drop procedure if exists myloop109;
delimiter $
create procedure myloop109(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt109 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w109_normalized_languages w on w.id=w0.id where w0.normalized_languages_Q>0 and w.id is null limit ? ;" ;
 execute mystmt109 using @l;
 DEALLOCATE PREPARE mystmt109; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt109b from "insert ignore into wos.w109_normalized_languages select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/normalized_languages/language[$@i]/@type'), ExtractValue(x.xml,'//static_data/fullrecord_metadata/normalized_languages/language[$@i]') from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.normalized_languages_Q>=n.seq where w0.normalized_languages_Q>0;" ;
   execute mystmt109b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt109b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w109_normalized_languages); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w109_normalized_languages'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  

-- table w110_normalized_doctypes
drop procedure if exists myloop110;
delimiter $
create procedure myloop110(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt110 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w110_normalized_doctypes w on w.id=w0.id where w0.normalized_doctypes_Q>0 and w.id is null limit ? ;" ;
 execute mystmt110 using @l;
 DEALLOCATE PREPARE mystmt110; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt110b from "insert ignore into wos.w110_normalized_doctypes select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/normalized_doctypes/doctype[$@i]') from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.normalized_doctypes_Q>=n.seq where w0.normalized_doctypes_Q>0;" ;
   execute mystmt110b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt110b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w110_normalized_doctypes); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w110_normalized_doctypes'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  


-- table w111_references
drop procedure if exists myloop111;
delimiter $
create procedure myloop111(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt111 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w111_references w on w.id=w0.id where w0.references_Q>0 and w.id is null limit ? ;" ;
 execute mystmt111 using @l;
 DEALLOCATE PREPARE mystmt111; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt111b from "insert ignore into wos.w111_references select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/reference[$@i]/uid') as cited_UID, ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/reference[$@i]/citedAuthor') as cited_Author, ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/reference[$@i]/year') as cited_year, ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/reference[$@i]/page') as cited_page, ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/reference[$@i]/volume') as cited_volume, ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/reference[$@i]/citedTitle//descendant::node()') as cited_Title, ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/reference[$@i]/citedWork') as cited_Work, ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/reference[$@i]/art_no') as art_no,  ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/reference[$@i]/doi') as cited_doi , ExtractValue(x.xml,'//static_data/fullrecord_metadata/references/reference[$@i]/patent_no') as cited_patent_no from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.references_Q>=n.seq where w0.references_Q>0;" ;
   execute mystmt111b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt111b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w111_references); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w111_references'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  


-- table w112_headings
drop procedure if exists myloop112;
delimiter $
create procedure myloop112(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt112 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w112_headings w on w.id=w0.id where w0.headings_Q>0 and w.id is null limit ? ;" ;
 execute mystmt112 using @l;
 DEALLOCATE PREPARE mystmt112; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt112b from "insert ignore into wos.w112_headings select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/category_info/headings/heading[$@i]') as heading from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.headings_Q>=n.seq where w0.headings_Q>0;" ;
   execute mystmt112b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt112b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w112_headings); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w112_headings'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  

-- table w113_subheadings
drop procedure if exists myloop113;
delimiter $
create procedure myloop113(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt113 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w113_subheadings w on w.id=w0.id where w0.subheadings_Q>0 and w.id is null limit ? ;" ;
 execute mystmt113 using @l;
 DEALLOCATE PREPARE mystmt113; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt113b from "insert ignore into wos.w113_subheadings select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/category_info/subheadings/subheading[$@i]') as subheading from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.subheadings_Q>=n.seq where w0.subheadings_Q>0;" ;
   execute mystmt113b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt113b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w113_subheadings); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w113_subheadings'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  


-- table w114_subjects
drop procedure if exists myloop114;
delimiter $
create procedure myloop114(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt114 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w114_subjects w on w.id=w0.id where w0.subjects_Q>0 and w.id is null limit ? ;" ;
 execute mystmt114 using @l;
 DEALLOCATE PREPARE mystmt114; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt114b from "insert ignore into wos.w114_subjects select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/category_info/subjects/subject[$@i]/@ascatype') as subject_type, ExtractValue(x.xml,'//static_data/fullrecord_metadata/category_info/subjects/subject[$@i]') as subject from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.subjects_Q>=n.seq where w0.subjects_Q>0;" ;
   execute mystmt114b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt114b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w114_subjects); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w114_subjects'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  

-- table w115_keywords
drop procedure if exists myloop115;
delimiter $
create procedure myloop115(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt115 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w115_keywords w on w.id=w0.id where w0.keywords_Q>0 and w.id is null limit ? ;" ;
 execute mystmt115 using @l;
 DEALLOCATE PREPARE mystmt115; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt115b from "insert ignore into wos.w115_keywords select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/keywords/keyword[$@i]') as keyword from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.keywords_Q>=n.seq where w0.keywords_Q>0;" ;
   execute mystmt115b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt115b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w115_keywords); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w115_keywords'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  

-- table w116_abstracts
drop procedure if exists myloop116;
delimiter $
create procedure myloop116(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt116 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w116_abstracts w on w.id=w0.id where w0.abstracts_Q>0 and w.id is null limit ? ;" ;
 execute mystmt116 using @l;
 DEALLOCATE PREPARE mystmt116; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt116b from "insert ignore into wos.w116_abstracts select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/abstracts/abstract[$@i]/abstract_text//descendant::node()') as abstract from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.abstracts_Q>=n.seq where w0.abstracts_Q>0;" ;
   execute mystmt116b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt116b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w116_abstracts); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w116_abstracts'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  

-- table w117_grants
drop procedure if exists myloop117;
delimiter $
create procedure myloop117(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt117 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w117_grants w on w.id=w0.id where w0.grants_Q>0 and w.id is null limit ? ;" ;
 execute mystmt117 using @l;
 DEALLOCATE PREPARE mystmt117; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt117b from "insert ignore into wos.w117_grants select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/fund_ack/fund_text//descendant::node()') as grants,  ExtractValue(x.xml,'//static_data/fullrecord_metadata/fund_ack/grants/grant[$@i]/grant_agency') as grant_agency, ExtractValue(x.xml,'//static_data/fullrecord_metadata/fund_ack/grants/grant[$@i]/grant_ids/@count')+0 as grant_ids_Q from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.grants_Q>=n.seq where w0.grants_Q>0;" ;
   execute mystmt117b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt117b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w117_grants); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w117_grants'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  

-- w117 grants ids
drop procedure if exists myloop117s;
delimiter $
create procedure myloop117s(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt117s from "create temporary table wos.myids (index(id)) select distinct w0.id from wos.w117_grants w0 left join wos.w117_grants_ids w on w.id=w0.id where w0.grant_ids_Q>0 and w.id is null limit ? ;" ;
 execute mystmt117s using @l;
 DEALLOCATE PREPARE mystmt117s; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt117sb from "insert ignore into wos.w117_grants_ids select w0.id, @m:=w0.grant_seq, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/fund_ack/grants/grant[$@m]/grant_ids/grant_id[$@i]') as grant_ids from (select * from wos.myids limit ? , ?) t inner join wos.w117_grants w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.grant_ids_Q>=n.seq where w0.grant_ids_Q>0;" ;
   execute mystmt117sb using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt117sb;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w117_grants_ids); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w117_grants_ids'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w118_addresses
drop procedure if exists myloop118;
delimiter $
create procedure myloop118(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt118 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w118_addresses w on w.id=w0.id where w0.addresses_Q>0 and w.id is null limit ? ;" ;
 execute mystmt118 using @l;
 DEALLOCATE PREPARE mystmt118; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt118b from "insert ignore into wos.w118_addresses select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/@addr_no') as addr_no , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/full_address') as full_address , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/street') as street, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/city') as city , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/zip/@location') as zip_location, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/zip') as zip , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/state') as state, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/country') as country , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/organizations/@count')+0 as addr_org_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/suborganizations/@count')+0 as addr_suborg_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/names/@count')+0 as addr_names_Q from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.addresses_Q>=n.seq where w0.addresses_Q>0;" ;
   execute mystmt118b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt118b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w118_addresses); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w118_addresses'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  

-- table w118_addresses (optmized)
drop procedure if exists myloop118bis;
delimiter $
create procedure myloop118bis(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt118_2 from "create temporary table wos.myids (index(id), index(addresses_Q)) select w0.id, w0.addresses_Q from wos.w100_counts w0 left join wos.w118_addresses w on w.id=w0.id where w0.addresses_Q>0 and w.id is null limit ? ;" ;
 execute mystmt118_2 using @l;
 DEALLOCATE PREPARE mystmt118_2; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt118_2b from "insert ignore into wos.w118_addresses select t.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/@addr_no') as addr_no , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/full_address') as full_address , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/street') as street, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/city') as city , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/zip/@location') as zip_location, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/zip') as zip , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/state') as state, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/country') as country , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/organizations/@count')+0 as addr_org_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/address_spec/suborganizations/@count')+0 as addr_suborg_Q, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@i]/names/@count')+0 as addr_names_Q from (select * from wos.myids limit ? , ?) t 	inner join rawXMLs x on x.id=t.id inner join wos.num n on t.addresses_Q>=n.seq;" ;
   execute mystmt118_2b using	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt118_2b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w118_addresses); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w118_addresses'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  



-- table w119_addr_org
drop procedure if exists myloop119;
delimiter $
create procedure myloop119(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt119 from "create temporary table wos.myids (index(id)) select distinct w0.id from wos.w118_addresses w0 left join wos.w119_addr_org w on w.id=w0.id where w0.addr_org_Q>0 and w.id is null limit ? ;" ; 
 execute mystmt119 using @l;
 DEALLOCATE PREPARE mystmt119; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt119b from "insert ignore into wos.w119_addr_org select w0.id, @m:=w0.address_seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name/address_spec/@addr_no') as addr_no, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/address_spec/organizations/organization[$@i]/@pref') as org_pref, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/address_spec/organizations/organization[$@i]') as organization from (select * from wos.myids limit ? , ?) t inner join wos.w118_addresses w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.addr_org_Q>=n.seq where w0.addr_org_Q>0;" ;
   execute mystmt119b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt119b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w119_addr_org); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w119_addr_org'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w120_addr_suborg
drop procedure if exists myloop120;
delimiter $
create procedure myloop120(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt120 from "create temporary table wos.myids (index(id)) select distinct w0.id from wos.w118_addresses w0 left join wos.w120_addr_suborg w on w.id=w0.id where w0.addr_suborg_Q>0 and w.id is null limit ? ;" ; 
 execute mystmt120 using @l;
 DEALLOCATE PREPARE mystmt120; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt120b from "insert ignore into wos.w120_addr_suborg select w0.id, @m:=w0.address_seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name/address_spec/@addr_no') as addr_no, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/address_spec/suborganizations/suborganization[$@i]') as suborganization from (select * from wos.myids limit ? , ?) t inner join wos.w118_addresses w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.addr_suborg_Q>=n.seq where w0.addr_suborg_Q>0;" ;
   execute mystmt120b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt120b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w120_addr_suborg); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w120_addr_suborg'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w121_addr_names
drop procedure if exists myloop121;
delimiter $
create procedure myloop121(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt121 from "create temporary table wos.myids (index(id)) select distinct w0.id from wos.w118_addresses w0 left join wos.w121_addr_names w on w.id=w0.id where w0.addr_names_Q>0 and w.id is null limit ? ;" ; 
 execute mystmt121 using @l;
 DEALLOCATE PREPARE mystmt121; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt121b from "insert ignore into wos.w121_addr_names select w0.id, @m:=w0.address_seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name/address_spec/@addr_no') as addr_no, @i:=n.seq, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/@addr_no') as name_addr_no, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/@dais_id') as dais_id , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/@orcid_id_tr') as orcid_id_tr ,   ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/@r_id') as r_id , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/@r_id_tr') as r_id_tr , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/@reprint') as reprint , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/@role') as role , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/@seq_no')+0 as seq_no , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/display_name') as display_name, ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/full_name') as full_name , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/wos_standard') as wos_standard , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/first_name') as  first_name , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/last_name') as  last_name , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/suffix') as suffix , ExtractValue(x.xml,'//static_data/fullrecord_metadata/addresses/address_name[$@m]/names/name[$@i]/email_addr') as email_addr from (select * from wos.myids limit ? , ?) t inner join wos.w118_addresses w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.addr_names_Q>=n.seq where w0.addr_names_Q>0;" ;
   execute mystmt121b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt121b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w121_addr_names); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w121_addr_names'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;


-- table w122_item
drop procedure if exists myloop122;
delimiter $
create procedure myloop122(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt122 from "create temporary table wos.myids (index(id)) select x.id from rawXMLs x left join wos.w122_item w0 using(id) where w0.id is null limit ? ;" ;
 execute mystmt122 using @l;
 DEALLOCATE PREPARE mystmt122;
 set @i:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @i <= mymax DO
  prepare mystmt122b from " insert ignore into w122_item select x.id, ExtractValue(x.xml,'//item/ids') as item_id, ExtractValue(x.xml,'//item/ids/@avail') as item_id_avail , ExtractValue(x.xml,'//item/bib_id') as  bib_id , ExtractValue(x.xml,'//item/bib_pagecount/@type') as  bib_type , ExtractValue(x.xml,'//item/bib_pagecount') as  bib_pagecount , ExtractValue(x.xml,'//item/book_desc/bk_binding') as  bk_binding , ExtractValue(x.xml,'//item/book_desc/bk_ordering') as  bk_ordering , ExtractValue(x.xml,'//item/book_desc/bk_prepay') as  bk_prepay , ExtractValue(x.xml,'//item/book_desc/bk_price/@volumes') as  bk_volumes , ExtractValue(x.xml,'//item/book_desc/bk_publisher') as  bk_publisher , ExtractValue(x.xml,'//item/book_notes/@count')+0 as book_notes_Q , ExtractValue(x.xml,'//item/book_notes/book_note') as  book_notes , ExtractValue(x.xml,'//item/book_pages') as  book_pages , ExtractValue(x.xml,'//item/keywords_plus/@count')+0 as keywords_Q from rawXMLs x inner join (select * from wos.myids limit ? , ?) w0 using(id);" ;
   execute mystmt122b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt122b;
   SET @i = @i + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w122_item); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w122_item'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w123_keywords
drop procedure if exists myloop123;
delimiter $
create procedure myloop123(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt123 from "create temporary table wos.myids (index(id)) select distinct w0.id from wos.w122_item w0 left join wos.w123_item_keywords w on w.id=w0.id where w0.keywords_Q>0 and w.id is null limit ? ;" ; 
 execute mystmt123 using @l;
 DEALLOCATE PREPARE mystmt123; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt123b from "insert ignore into wos.w123_item_keywords select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/item/keywords_plus/keyword[$@i]') as keyword from (select * from wos.myids limit ? , ?) t inner join wos.w122_item w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.keywords_Q>=n.seq where w0.keywords_Q>0;" ;
   execute mystmt123b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt123b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w123_item_keywords); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w123_item_keywords'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w124_reprint_addr
drop procedure if exists myloop124;
delimiter $
create procedure myloop124(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt124 from "create temporary table wos.myids (index(id)) select x.id from rawXMLs x left join wos.w124_reprint_addr w0 using(id) where w0.id is null limit ? ;" ;
 execute mystmt124 using @l;
 DEALLOCATE PREPARE mystmt124;
 set @i:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @i <= mymax DO
  prepare mystmt124b from " insert ignore into w124_reprint_addr select x.id, ExtractValue(x.xml,'//item/reprint_contact/address_spec/@addr_no') as addr_no , ExtractValue(x.xml,'//item/reprint_contact/address_spec/full_address') as full_address , ExtractValue(x.xml,'//item/reprint_contact/address_spec/street') as street, ExtractValue(x.xml,'//item/reprint_contact/address_spec/city') as city, ExtractValue(x.xml,'//item/reprint_contact/address_spec/zip/@location') as  zip_location, ExtractValue(x.xml,'//item/reprint_contact/address_spec/zip') as zip , ExtractValue(x.xml,'//item/reprint_contact/address_spec/state') as state , ExtractValue(x.xml,'//item/reprint_contact/address_spec/country') as country, ExtractValue(x.xml,'//item/reprint_contact/address_spec/organizations/@count')+0 as org_Q, ExtractValue(x.xml,'//item/reprint_contact/address_spec/suborganizations/@count')+0 as suborg_Q, ExtractValue(x.xml,'//item/reprint_contact/names/@count')+0 as names_Q from rawXMLs x inner join (select * from wos.myids limit ? , ?) w0 using(id);" ;
   execute mystmt124b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt124b;
   SET @i = @i + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w124_reprint_addr); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w124_reprint_addr'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w125_reprint_org
drop procedure if exists myloop125;
delimiter $
create procedure myloop125(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt125 from "create temporary table wos.myids (index(id)) select distinct w0.id from w124_reprint_addr w0 left join wos.w125_reprint_org w using(id) where w0.org_Q>0 and w.id is null limit ? ;" ;
 execute mystmt125 using @l;
 DEALLOCATE PREPARE mystmt125;
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
  prepare mystmt125b from " insert ignore into wos.w125_reprint_org select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/item/reprint_contact/address_spec/organizations/organization[$@i]/@pref') as org_pref, ExtractValue(x.xml,'//static_data/item/reprint_contact/address_spec/organizations/organization[$@i]') as organization from (select * from wos.myids limit ? , ?) t inner join wos.w124_reprint_addr w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.org_Q>=n.seq where w0.org_Q>0;" ;
	execute mystmt125b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt125b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w125_reprint_org); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w125_reprint_org'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w126_reprint_suborg
drop procedure if exists myloop126;
delimiter $
create procedure myloop126(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt126 from "create temporary table wos.myids (index(id)) select distinct w0.id from w124_reprint_addr w0 left join wos.w126_reprint_suborg w using(id) where w0.suborg_Q>0 and w.id is null limit ? ;" ;
 execute mystmt126 using @l;
 DEALLOCATE PREPARE mystmt126;
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
  prepare mystmt126b from " insert ignore into wos.w126_reprint_suborg select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/item/reprint_contact/address_spec/suborganizations/suborganization[$@i]') as suborg from (select * from wos.myids limit ? , ?) t inner join wos.w124_reprint_addr w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.suborg_Q>=n.seq where w0.suborg_Q>0;" ;
	execute mystmt126b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt126b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w126_reprint_suborg); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w126_reprint_suborg'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w127_reprint_addr_name
drop procedure if exists myloop127;
delimiter $
create procedure myloop127(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt127 from "create temporary table wos.myids (index(id)) select distinct w0.id from w124_reprint_addr w0 left join wos.w127_reprint_addr_name w using(id) where w0.names_Q>0 and w.id is null limit ? ;" ;
 execute mystmt127 using @l;
 DEALLOCATE PREPARE mystmt127;
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
  prepare mystmt127b from " insert ignore into wos.w127_reprint_addr_name select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/@addr_no') as name_addr_no, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/dais_id') as dais_id, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/display') as display, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/r_id') as r_id, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/reprint') as reprint, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/role') as role, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/seq_no')+0 as seq_no, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/full_name') as full_name, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/display_name') as display_name, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/email_addr') as email_addr, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/first_name') as first_name, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/last_name') as last_name, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/suffix') as suffix, ExtractValue(x.xml,'//static_data/item/reprint_contact/names/name[$@i]/wos_standard') as wos_standard  from (select * from wos.myids limit ? , ?) t inner join wos.w124_reprint_addr w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.names_Q>=n.seq where w0.names_Q>0;" ;
	execute mystmt127b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt127b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w127_reprint_addr_name); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w127_reprint_addr_name'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w128_reviewed_work 
drop procedure if exists myloop128;
delimiter $
create procedure myloop128(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt128 from "create temporary table wos.myids (index(id)) select x.id from rawXMLs x left join wos.w128_reviewed_work w0 using(id) where w0.id is null limit ? ;" ;
 execute mystmt128 using @l;
 DEALLOCATE PREPARE mystmt128;
 set @i:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @i <= mymax DO
  prepare mystmt128b from " insert ignore into wos.w128_reviewed_work select x.id, ExtractValue(x.xml,'//item/reviewed_work/languages/@count')+0 as reviewed_work_Q , ExtractValue(x.xml,'//item/reviewed_work/languages/language') as reviewed_work_lang , ExtractValue(x.xml,'//item/reviewed_work/rw_authors/@count')+0 as  rw_authors_Q, ExtractValue(x.xml,'//item/reviewed_work/rw_year') as rw_year from rawXMLs x inner join (select * from wos.myids limit ? , ?) w0 using(id);" ;
   execute mystmt128b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt128b;
   SET @i = @i + 1 ;
   SET @j = @j +  @b ;
  set @c:=(SELECT count(*) FROM wos.w128_reviewed_work); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w128_reviewed_work'; commit; 
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;


-- wos.w128_rw_authors 
drop procedure if exists myloop128s;
delimiter $
create procedure myloop128s(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt128s from "create temporary table wos.myids (index(id)) select distinct w0.id from wos.w128_reviewed_work w0 left join wos.w128_rw_authors w on w.id=w0.id where w0.rw_authors_Q>0 and w.id is null limit ? ;" ;
 execute mystmt128s using @l;
 DEALLOCATE PREPARE mystmt128s; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt128sb from "insert ignore into wos.w128_rw_authors select w0.id, @i:=n.seq, ExtractValue(x.xml,'//item/reviewed_work/rw_authors/rw_author[$@i]') as  rw_authors 	from (select * from wos.myids limit ? , ?) t inner join wos.w128_reviewed_work w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.rw_authors_Q>=n.seq where w0.rw_authors_Q>0;" ;
   execute mystmt128sb using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt128sb;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w128_rw_authors); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w128_rw_authors'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w129_contributors
drop procedure if exists myloop129;
delimiter $
create procedure myloop129(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt129 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w129_contributors w on w.id=w0.id where w0.contributors_Q>0 and w.id is null limit ? ;" ;
 execute mystmt129 using @l;
 DEALLOCATE PREPARE mystmt129; 
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt129b from "insert ignore into wos.w129_contributors select w0.id, @i:=n.seq, ExtractValue(x.xml,'//static_data/contributors/contributor[$@i]/name/@orcid_id') as orcid_id , 	 ExtractValue(x.xml,'//static_data/contributors/contributor[$@i]/name/@r_id') as r_id , ExtractValue(x.xml,'//static_data/contributors/contributor[$@i]/name/@role') as  role , ExtractValue(x.xml,'//static_data/contributors/contributor[$@i]/name/@seq_no')+0 as  seq_no , ExtractValue(x.xml,'//static_data/contributors/contributor[$@i]/name/full_name') as  full_name , ExtractValue(x.xml,'//static_data/contributors/contributor[$@i]/name/display_name') as  display_name , ExtractValue(x.xml,'//static_data/contributors/contributor[$@i]/name/first_name') as  first_name , ExtractValue(x.xml,'//static_data/contributors/contributor[$@i]/name/last_name') as  last_name from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join rawXMLs x on x.id=t.id inner join wos.num n on w0.contributors_Q>=n.seq where w0.contributors_Q>0;" ;
   execute mystmt129b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt129b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
   set @c:=(SELECT count(*) FROM wos.w129_contributors); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w129_contributors'; commit;
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;  

-- table w130_identifiers
drop procedure if exists myloop130;
delimiter $
create procedure myloop130(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt130 from "create temporary table wos.myids (index(id)) select w0.id from wos.w100_counts w0 left join wos.w130_identifiers w using(id) where w0.identifiers_Q>0 and w.id is null limit ? ;" ;
 execute mystmt130 using @l;
 DEALLOCATE PREPARE mystmt130;
 set @k:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @k <= mymax DO
   prepare mystmt130b from "insert ignore into wos.w130_identifiers select w0.id, @i:=n.seq, ExtractValue(x.xml,'//dynamic_data/cluster_related/identifiers/identifier[$@i]/@type') as type, ExtractValue(x.xml,'//dynamic_data/cluster_related/identifiers/identifier[$@i]/@value') as identifier from (select * from wos.myids limit ? , ?) t inner join wos.w100_counts w0 on t.id=w0.id inner join wos.rawXMLs x on x.id=t.id inner join wos.num n on w0.identifiers_Q>=n.seq where w0.identifiers_Q>0;" ;
   execute mystmt130b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt130b;
   SET @k = @k + 1 ;
   SET @j = @j +  @b ;
  set @c:=(SELECT count(*) FROM wos.w130_identifiers); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w130_identifiers'; commit; 
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

-- table w131_ic_related
drop procedure if exists myloop131;
delimiter $
create procedure myloop131(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt131 from "create temporary table wos.myids (index(id)) select x.id from wos.rawXMLs x left join wos.w131_ic_related w0 using(id) where w0.id is null limit ? ;" ;
 execute mystmt131 using @l;
 DEALLOCATE PREPARE mystmt131;
 set @i:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @i <= mymax DO
  prepare mystmt131b from " insert ignore into wos.w131_ic_related select x.id, ExtractValue(x.xml,'//dynamic_data/ic_related/oases/@count')+0 as oases_Q, ExtractValue(x.xml,'//dynamic_data/ic_related/oases/oas/@type') as oases_type, ExtractValue(x.xml,'//dynamic_data/ic_related/oases/oas') as oas from wos.rawXMLs x inner join (select * from wos.myids limit ? , ?) w0 using(id);" ;
   execute mystmt131b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt131b;
   SET @i = @i + 1 ;
   SET @j = @j +  @b ;
  set @c:=(SELECT count(*) FROM wos.w131_ic_related); 
  update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w131_ic_related'; commit; 
  END WHILE;
  drop temporary table if exists wos.myids;
END $
delimiter ;

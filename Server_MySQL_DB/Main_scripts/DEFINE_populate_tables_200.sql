drop procedure if exists myloop211;
delimiter $
create procedure myloop211(mymax int, batch int)
BEGIN
 DECLARE CONTINUE HANDLER FOR 1205 SELECT 'Timed-out updating table_status' as msg;
 set @l:= mymax * batch ;
 drop temporary table if exists wos.myids;
 prepare mystmt211 from "create temporary table wos.myids (index(id)) select distinct w.id from wos.w111_references w left join wos.w211_citations t on w.id=t.citing_id  where t.citing_id is null limit ? ;" ;
 execute mystmt211 using @l;
 DEALLOCATE PREPARE mystmt211;
 set @i:=1;
 set @j:=0;
 set @b:= batch ;
 WHILE @i <= mymax DO
  prepare mystmt211b from "insert ignore into wos.w211_citations select distinct w11.id as citing_id, u.id as cited_id, datediff(w1.sortdate, w1c.sortdate)/365 as cit_lag from wos.w111_references w11 inner join (select * from wos.myids limit ? , ?) w0 on w11.id=w0.id inner join wos.UIDs u on w11.cited_UID=u.UID inner join wos.w101_summary w1 on w11.id=w1.id inner join wos.w101_summary w1c on u.id=w1c.id ;" ;
   execute mystmt211b using 	@j,  @b;
   commit;
   DEALLOCATE PREPARE mystmt211b;
   SET @i = @i + 1 ;
   SET @j = @j +  @b ;
   -- set @c:=(SELECT count(*) FROM wos.w211_citations);
   -- update wos.table_status s set s.rows=@c, s.ratio=round(s.rows/s.benchmark*100,2) where s.table_name='w211_citations'; commit; 
 END WHILE;
 drop temporary table if exists wos.myids;
END $
delimiter ;

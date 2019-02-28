use wos;
insert into wos.UIDs select x.UID, replace(upper(x.file), '.XML', '') as file, x.loaded, x.id from wos.rawXMLs x left join wos.UIDs u using(id) where u.id is null; commit;
select @maxIDx:=max(x.id) from wos.rawXMLs x ;  
select @maxIDu:=max(u.id) from wos.UIDs u ;
select if(@maxIDx>@maxIDu, @maxmax:=@maxIDx+1, @maxmax:=@maxIDu+1);
set @mystmt = concat("CREATE TABLE wos.rawXMLs (`xml` LONGBLOB NULL, `UID` VARCHAR(25) NOT NULL DEFAULT '', `file` VARCHAR(255) NOT NULL DEFAULT '',`loaded` DATETIME NULL DEFAULT NULL, `id` INT(11) NOT NULL AUTO_INCREMENT,	PRIMARY KEY (`UID`, `file`), INDEX `id` (`id`)) COLLATE='utf8_general_ci' ENGINE=InnoDB AUTO_INCREMENT=", @maxmax);
prepare mystmt from  @mystmt;
drop table if exists wos.rawXMLs; commit;
execute mystmt; commit;
 
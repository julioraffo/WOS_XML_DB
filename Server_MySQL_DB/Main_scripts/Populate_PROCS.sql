use wos;
-- 100) Counts (~30 mins every 500k) 
select @a:=count(*) from wos.rawXMLs x left join wos.w100_counts w0 using(id) where w0.id is null;
call wos.myloop100(floor(@a/100000)+1,100000);

-- 101) summary (~30 mins every 500k)
select @b:=count(*) from wos.rawXMLs x left join wos.w101_summary w1 using(id) where w1.id is null;
call wos.myloop101(floor(@b/100000)+1,100000);

-- 102) Editions 
select @b:=count(*) from wos.w100_counts w0 left join wos.w102_editions w using(id) where w0.edition_Q>0 and w.id is null;
call wos.myloop102(floor(@b/100000)+1,100000);

-- 103) Titles
select @b:=count(*) from wos.w100_counts w0 left join wos.w103_titles w using(id) where w0.titles_Q>0 and w.id is null;
call wos.myloop103(floor(@b/100000)+1,100000);  

-- 104) Names
select @b:=count(*) from wos.w100_counts w0 left join wos.w104_names w using(id) where w0.names_Q>0 and w.id is null;
call wos.myloop104(floor(@b/100000)+1,100000);  

-- 105) doctypes 
select @b:=count(*) from wos.w100_counts w0 left join wos.w105_doctypes w using(id) where w0.doctypes_Q>0 and w.id is null;
call wos.myloop105(floor(@b/100000)+1,100000);  

-- 106) conferences
select @b:=count(*) from wos.w100_counts w0 left join wos.w106_conferences w on w.id=w0.id where w0.conferences_Q>0 and w.id is null ;
call wos.myloop106(floor(@b/100000)+1,100000);  

-- 106s) conferences Sponsors
select @b:=count(distinct w0.id) from wos.w106_conferences w0 left join wos.w106_conf_sponsors w on w.id=w0.id where w0.conf_sponsors_Q>0 and w.id is null ;
call wos.myloop106s(floor(@b/100000)+1,100000);  

-- 107) publishers
select @b:=count(*) from wos.w100_counts w0 left join wos.w107_publishers w on w.id=w0.id where w0.publishers_Q>0 and w.id is null ;
call wos.myloop107(floor(@b/100000)+1,100000);  

-- 108) lang
select @b:=count(*) from wos.w100_counts w0 left join wos.w108_languages w on w.id=w0.id where w0.languages_Q>0 and w.id is null ;
call wos.myloop108(floor(@b/100000)+1,100000);  


-- 109) norm lang
select @b:=count(*) from wos.w100_counts w0 left join wos.w109_normalized_languages w on w.id=w0.id where w0.normalized_languages_Q>0 and w.id is null ;
call wos.myloop109(floor(@b/100000)+1,100000);  

-- 110) norm doctypes
select @b:=count(*) from wos.w100_counts w0 left join wos.w110_normalized_doctypes w on w.id=w0.id where w0.normalized_doctypes_Q>0 and w.id is null ;
call wos.myloop110(floor(@b/100000)+1,100000);  

-- 111) references
select @b:=count(*) from wos.rawXMLs x left join wos.w111_references w on w.id=x.id where w.id is null ;
call wos.myloop111(floor(@b/100000)+1,100000);  

-- 112) headings
select @b:=count(*) from wos.w100_counts w0 left join wos.w112_headings w on w.id=w0.id where w0.headings_Q>0 and w.id is null ;
call wos.myloop112(floor(@b/100000)+1,100000);  

-- 113) subheadings
select @b:=count(*) from wos.w100_counts w0 left join wos.w113_subheadings w on w.id=w0.id where w0.subheadings_Q>0 and w.id is null ;
call wos.myloop113(floor(@b/100000)+1,100000);  

-- 114) subjects
select @b:=count(*) from wos.w100_counts w0 left join wos.w114_subjects w on w.id=w0.id where w0.subjects_Q>0 and w.id is null ;
call wos.myloop114(floor(@b/100000)+1,100000);  

-- 115) keywords
select @b:=count(*) from wos.w100_counts w0 left join wos.w115_keywords w on w.id=w0.id where w0.keywords_Q>0 and w.id is null ;
call wos.myloop115(floor(@b/100000)+1,100000);  

-- 116)abstracts
select @b:=count(*) from wos.w100_counts w0 left join wos.w116_abstracts w on w.id=w0.id where w0.abstracts_Q>0 and w.id is null ;
call wos.myloop116(floor(@b/100000)+1,100000);  

-- 117) grants
select @b:=count(*) from wos.w100_counts w0 left join wos.w117_grants w on w.id=w0.id where w0.grants_Q>0 and w.id is null ;
call wos.myloop117(floor(@b/100000)+1,100000);  

-- 117s) grants IDs
select @b:=count(distinct w0.id) from wos.w117_grants w0 left join wos.w117_grants_ids w on w.id=w0.id where w0.grant_ids_Q>0 and w.id is null ;
call wos.myloop117s(floor(@b/100000)+1,100000);  

-- 118) addresses
select @b:=count(*) from wos.w100_counts w0 left join wos.w118_addresses w on w.id=w0.id where w0.addresses_Q>0 and w.id is null ;
call wos.myloop118(floor(@b/10000)+1,10000);  

-- 119) addresses org
select @b:=count(distinct w0.id) from wos.w118_addresses w0 left join wos.w119_addr_org w on w.id=w0.id and w.address_seq=w0.address_seq where w0.addr_org_Q>0 and w.id is null ;
call wos.myloop119(floor(@b/100000)+1,100000);  

-- 120) addresses suborg
select @b:=count(distinct w0.id) from wos.w118_addresses w0 left join wos.w120_addr_suborg w on w.id=w0.id where w0.addr_suborg_Q>0 and w.id is null ;
call wos.myloop120(floor(@b/100000)+1,100000);  

-- 121) addresses names
select @b:=count(distinct w0.id) from wos.w118_addresses w0 left join wos.w121_addr_names w on w.id=w0.id -- and w.address_seq=w0.address_seq
where w0.addr_names_Q>0 and w.id is null;
call wos.myloop121(floor(@b/100000)+1,100000);  

-- 122
select @b:=count(*) from wos.rawXMLs x left join wos.w122_item w1 using(id) where w1.id is null;
call wos.myloop122(floor(@b/100000)+1,100000);

-- 123
select @b:=count(distinct w0.id) from wos.w122_item w0 left join wos.w123_item_keywords w on w.id=w0.id where w0.keywords_Q>0 and w.id is null ;
call wos.myloop123(floor(@b/100000)+1,100000);  

-- 124
select @b:=count(distinct w0.id) from wos.rawXMLs w0 left join wos.w124_reprint_addr w on w.id=w0.id where w.id is null ;
call wos.myloop124(floor(@b/100000)+1,100000); 

-- 125
select @b:=count(distinct w0.id) from wos.w124_reprint_addr w0 left join wos.w125_reprint_org w using(id) where w0.org_Q>0 and w.id is null;
call wos.myloop125(floor(@b/100000)+1,100000); 

-- 126
select @b:=count(distinct w0.id) from wos.w124_reprint_addr w0 left join wos.w126_reprint_suborg w using(id) where w0.suborg_Q>0 and w.id is null;
call wos.myloop126(floor(@b/100000)+1,100000); 


-- 127
select @b:=count(distinct w0.id) from wos.w124_reprint_addr w0 left join wos.w127_reprint_addr_name w using(id) where w0.names_Q>0 and w.id is null;
call wos.myloop127(floor(@b/100000)+1,100000); 

-- 128
select @b:=count(distinct w0.id) from wos.rawXMLs w0 left join wos.w128_reviewed_work w using(id) where w.id is null;
call wos.myloop128(floor(@b/100000)+1,100000); 

-- 128s
select @b:=count(distinct w0.id) from wos.w128_reviewed_work w0 left join wos.w128_rw_authors w on w.id=w0.id where w0.rw_authors_Q>0 and w.id is null ;
call wos.myloop128s(floor(@b/100000)+1,100000);  

-- 129
select @b:=count(*) from wos.w100_counts w0 left join wos.w129_contributors w on w.id=w0.id where w0.contributors_Q>0 and w.id is null ;
call wos.myloop129(floor(@b/100000)+1,100000);  

-- 130
select @b:=count(*) from wos.w100_counts w0 left join wos.w130_identifiers w on w.id=w0.id where w0.identifiers_Q>0 and w.id is null ;
call wos.myloop130(floor(@b/100000)+1,100000);  

-- 131 table w131_ic_related
select @c:=count(*)   from wos.rawXMLs x left join wos.w131_ic_related w using(id) where w.id is null;
call wos.myloop131(floor(@c/100000)+1,100000);


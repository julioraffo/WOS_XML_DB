-- Creates WoS database (Server)
use wos;
create table wos.rawXMLs (
 xml longblob, 
 UID varchar(25), 
 file varchar(255), 
 loaded datetime,
 id int not null auto_increment, 
 constraint PK_UID primary key(UID, file), 
 index(id)); 

-- 100) Counts
create table w100_counts (
 id int, 
 edition_Q int, 
 titles_Q int, 
 names_Q int, 
 doctypes_Q int, 
 conferences_Q int,
 publishers_Q int, 
 languages_Q int, 
 normalized_languages_Q int, 
 normalized_doctypes_Q int, 
 references_Q int, 
 headings_Q int, 
 subheadings_Q int, 
 subjects_Q int, 
 keywords_Q int, 
 abstracts_Q int,
 grants_Q int,
 addresses_Q int,
 contributors_Q int,
 identifiers_Q int,
 primary key(id)
 );
alter table w100_counts add index(edition_Q), add index(titles_Q), add index(names_Q) , add index(doctypes_Q), add index(conferences_Q), add index(publishers_Q), add index(languages_Q) , 
add index(normalized_languages_Q) , add index(normalized_doctypes_Q) , add index(references_Q) , add index(headings_Q) , add index(subheadings_Q) , add index(subjects_Q) , add index(keywords_Q) , 
add index(abstracts_Q), add index(grants_Q), add index(addresses_Q); 

drop table if exists wos.num;
CREATE TABLE wos.num (seq INT(11) NOT NULL AUTO_INCREMENT,	INDEX(seq));
insert into wos.num select null from wos.w100_counts limit 10000; commit;

-- 101) summary
create table w101_summary (
 id int, 
 WUID varchar(5),
 coverdate varchar(12),
 has_abstract varchar(2),
 issue varchar(25), -- doc()/records/REC/static_data/summary/pub_info/@issue
 part_no varchar(25), -- doc()/records/REC/static_data/summary/pub_info/@part_no
 pubmonth varchar(15),
 pubtype varchar(25),
 pubyear int,
 sortdate varchar(12),
 special_issue varchar(25), -- doc()/records/REC/static_data/summary/pub_info/@special_issue
 supplement varchar(25), -- doc()/records/REC/static_data/summary/pub_info/@supplement
 vol varchar(12),
 page_begin varchar(25),
 page_end varchar(25),
 page_count int, 
 pages varchar(25),
 primary key(id)
 );

-- table w102_editions
create table wos.w102_editions (
 id int, 
 edition_seq int, 
 edition varchar(50),
 primary key(id, edition_seq), index(id));

-- table w103_titles
create table wos.w103_titles (
 id int, 
 title_seq int, 
 title_translated varchar(255), -- doc()/records/REC/static_data/summary/titles/title/@translated
 title_type varchar(50), 
 title varchar(255),
 primary key(id, title_seq), index(id));

-- table w104_names
create table wos.w104_names (
 id int, 
 name_seq int, 
 addr_no varchar(50),
 dais_id varchar(50), -- doc()/records/REC/static_data/summary/names/name/@dais_id
 orcid_id_tr varchar(50), -- doc()/records/REC/static_data/summary/names/name/@orcid_id_tr
 r_id varchar(50), -- doc()/records/REC/static_data/summary/names/name/@r_id
 r_id_tr varchar(50), -- doc()/records/REC/static_data/summary/names/name/@r_id_tr
 reprint varchar(2), 
 role varchar(50), 
 seq_no int, 
 display_name varchar(255), 
 full_name varchar(255), 
 wos_standard varchar(255),
 first_name varchar(255), 
 last_name varchar(255),
 suffix varchar(50), -- doc()/records/REC/static_data/summary/names/name/suffix/text()
 email_addr varchar(255),
 primary key(id, name_seq), index(id));

-- table w105_doctypes
create table wos.w105_doctypes (
 id int, 
 doctype_seq int, 
 doctype varchar(255),
 primary key(id, doctype_seq), index(id));

-- table w106_conferences
create table wos.w106_conferences (
 id int, 
 conference_seq int, 
 conf_id int,
 conf_infos_Q int, 
 conf_info blob, 
 conf_titles_Q int, 
 conf_title varchar(255), 
 conf_dates_Q int,
 conf_date_start varchar(255),
 conf_date_end varchar(255), -- doc()/records/REC/static_data/summary/conferences/conference/conf_dates/conf_date/@conf_end
 conf_date varchar(255), 
 conf_locations_Q int, 
 conf_host varchar(255), 
 conf_city varchar(255), 
 conf_state varchar(255),
 conf_sponsors_Q int, -- doc()/records/REC/static_data/summary/conferences/conference/sponsors/@count
 primary key(id, conference_seq), 
 index(id), 
 index(conf_sponsors_Q));

create table wos.w106_conf_sponsors (
 id int, 
 conference_seq int,
 conf_sponsors_seq int, 
 conf_sponsors varchar(255), -- doc()/records/REC/static_data/summary/conferences/conference/sponsors/sponsor/text()
 primary key(id, conference_seq, conf_sponsors_seq), 
 index(id));

-- table w107_publishers
create table wos.w107_publishers (
 id int, 
 publishers_seq int, 
 pub_addr_no varchar(255), 
 pub_full_address varchar(255), 
 pub_city varchar(255), 
 pub_n_addr_no int, 
 pub_role varchar(255), 
 pub_seq_no int, 
 pub_display_name varchar(255), 
 pub_full_name varchar(255), 
 primary key(id, publishers_seq), 
 index(id));

-- table w108_languages
create table wos.w108_languages (
 id int, 
 language_seq int, 
 language_type varchar(50), 
 language varchar(255), 
 primary key(id, language_seq), 
 index(id));

-- table w109_normalized_languages
create table wos.w109_normalized_languages (
 id int, 
 language_seq int, 
 language_type varchar(50), 
 language varchar(255), 
 primary key(id, language_seq), 
 index(id));

-- table w110_normalized_doctypes
create table wos.w110_normalized_doctypes (
 id int, 
 norm_doctype_seq int, 
 norm_doctype varchar(255), 
 primary key(id, norm_doctype_seq ), 
 index(id));

-- table w111_references
create table wos.w111_references (
 id int, 
 reference_seq int, 
 cited_UID varchar(255), 
 cited_Author varchar(255),
 cited_year varchar(25), 
 cited_page varchar(25), 
 cited_volume varchar(25), 
 cited_Title blob,  -- doc()/records/REC/static_data/fullrecord_metadata/references/reference/citedTitle
 cited_Work  varchar(255),
 art_no  varchar(50), -- doc()/records/REC/static_data/fullrecord_metadata/references/reference/art_no/text()
 cited_doi varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/references/reference/doi/text()
 cited_patent_no varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/references/reference/patent_no/text()
 primary key(id, reference_seq ), 
 index(id) );

-- table w112_headings
create table wos.w112_headings (
 id int, 
 heading_seq int, 
 heading varchar(255), 
 primary key(id, heading_seq ), 
 index(id));
 
-- table w113_subheadings
create table wos.w113_subheadings (
 id int, 
 subheading_seq int, 
 subheading varchar(255), 
 primary key(id, subheading_seq ), 
 index(id));

-- table w114_subjects
create table wos.w114_subjects (
 id int, 
 subject_seq int, 
 subject_type varchar(255), 
 subject varchar(255), 
 primary key(id, subject_seq ), 
 index(id));

-- table w115_keywords
create table wos.w115_keywords (
 id int, 
 keyword_seq int, 
 keyword varchar(255), 
 primary key(id, keyword_seq ), 
 index(id));

-- table w116_abstracts
create table wos.w116_abstracts (
 id int, 
 abstract_seq int, 
 abstract longblob, 
 primary key(id, abstract_seq ), 
 index(id));

-- table w117_grants
create table wos.w117_grants (
 id int, 
 grant_seq int, 
 grants blob, -- doc()/records/REC/static_data/fullrecord_metadata/fund_ack/fund_text/p/text()
 grant_agency varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/fund_ack/grants/grant/grant_agency/text()
 grant_ids_Q int, -- doc()/records/REC/static_data/fullrecord_metadata/fund_ack/grants/grant/grant_ids/@count
 primary key(id, grant_seq ), 
 index(id), INDEX (grant_ids_Q));

-- table w117_grants_ids
create table wos.w117_grants_ids (
 id int, 
 grant_seq int, 
 grant_ids_seq int, -- doc()/records/REC/static_data/fullrecord_metadata/fund_ack/grants/grant/grant_ids/@count
 grant_ids varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/fund_ack/grants/grant/grant_ids/grant_id/text()
 primary key(id, grant_seq, grant_ids_seq), 
 index(id,grant_seq));

-- table w118_addresses
create table wos.w118_addresses (
 id int, 
 address_seq int,
 addr_no varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/@addr_no
 full_address varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/full_address/text()
 street varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/street/text()
 city varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/city/text()
 zip_location varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/zip/@location
 zip varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/zip/text()
 state varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/state/text()
 country varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/country/text()
 addr_org_Q int, -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/organizations/@count
 addr_suborg_Q int, -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/suborganizations/@count
 addr_names_Q int, -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/@count
 primary key(id, address_seq), 
 index(id), index(addr_org_Q), index(addr_suborg_Q), index(addr_names_Q));

-- table w119_addr_org
create table wos.w119_addr_org (
 id int, 
 address_seq int,
 addr_no varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/@addr_no 
 org_seq int,  
 org_pref varchar(5), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/organizations/organization/@pref
 organization varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/organizations/organization/text()
 primary key(id, address_seq, org_seq), 
 index(id));

-- table w120_addr_suborg
create table wos.w120_addr_suborg (
 id int,
 address_seq int,
 addr_no varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/@addr_no  
 suborg_seq int,
 suborganization varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/suborganizations/suborganization/text()
 primary key(id, address_seq, suborg_seq), 
 index(id));

-- table w121_addr_names
create table wos.w121_addr_names (
 id int,
 address_seq int,
 addr_no varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/address_spec/@addr_no   
 name_seq int, 
 name_addr_no int, -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/@addr_no
 dais_id varchar(50), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/@dais_id
 orcid_id_tr varchar(50), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/@orcid_id_tr
 r_id varchar(50), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/@r_id
 r_id_tr varchar(50), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/@r_id_tr
 reprint varchar(50), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/@reprint
 role varchar(50), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/@role
 seq_no int, -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/@seq_no
 display_name varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/display_name/text()
 full_name varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/full_name/text()
 wos_standard varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/wos_standard/text()
 first_name varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/first_name/text()
 last_name varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/last_name/text()
 suffix varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/suffix/text()
 email_addr varchar(255), -- doc()/records/REC/static_data/fullrecord_metadata/addresses/address_name/names/name/email_addr/text()
 primary key(id, address_seq, name_seq), 
 index(id)
 index(id, address_seq));

-- table w122_item
create table wos.w122_item (
 id int,
 item_id varchar(25), -- doc()/records/REC/static_data/item/ids/text()
 item_id_avail varchar(25), -- doc()/records/REC/static_data/item/ids/@avail
 bib_id varchar(255), -- doc()/records/REC/static_data/item/bib_id/text()
 bib_type varchar(25), -- doc()/records/REC/static_data/item/bib_pagecount/@type
 bib_pagecount varchar(25), -- doc()/records/REC/static_data/item/bib_pagecount/text()
 bk_binding varchar(25), -- doc()/records/REC/static_data/item/book_desc/bk_binding/text()
 bk_ordering varchar(255), -- doc()/records/REC/static_data/item/book_desc/bk_ordering/text()
 bk_prepay varchar(25), -- doc()/records/REC/static_data/item/book_desc/bk_prepay/text()
 bk_volumes varchar(25), -- doc()/records/REC/static_data/item/book_desc/bk_price/@volumes
 bk_publisher varchar(255), -- doc()/records/REC/static_data/item/book_desc/bk_publisher/text()
 book_notes_Q int, -- doc()/records/REC/static_data/item/book_notes/@count
 book_notes varchar(25), -- doc()/records/REC/static_data/item/book_notes/book_note/text()
 book_pages varchar(25), -- doc()/records/REC/static_data/item/book_pages/text()
 keywords_Q int, -- doc()/records/REC/static_data/item/keywords_plus/@count
 primary key(id),
 INDEX(keywords_Q));

create table wos.w123_item_keywords (
 id int, 
 keyword_seq int,
 keywords varchar(255), -- doc()/records/REC/static_data/item/keywords_plus/keyword/text()
 primary key(id, keyword_seq), 
 index(id));

create table wos.w124_reprint_addr (
 id int, 
 addr_no varchar(255), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/@addr_no
 full_address varchar(255), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/full_address/text()
 street varchar(255), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/street/text()
 city varchar(255), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/city/text()
 zip_location varchar(255), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/zip/@location
 zip varchar(255), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/zip/text()
 state varchar(255), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/state/text()
 country varchar(255), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/country/text()
 org_Q int, -- doc()/records/REC/static_data/item/reprint_contact/address_spec/organizations/@count
 suborg_Q int, -- doc()/records/REC/static_data/item/reprint_contact/address_spec/suborganizations/@count
 names_Q int, -- doc()/records/REC/static_data/item/reprint_contact/names/@count
 primary key(id),
 index(org_Q),
 index(suborg_Q),
 index(names_Q) 
 );

-- table w125_reprint_org
create table wos.w125_reprint_org (
 id int,
 org_seq int,  
 org_pref varchar(25), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/organizations/organization/@pref
 organization varchar(255), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/organizations/organization/text()
 primary key(id, org_seq), 
 index(id));

-- table w126_reprint_suborg
create table wos.w126_reprint_suborg (
 id int,
 suborg_seq int,
 suborg varchar(255), -- doc()/records/REC/static_data/item/reprint_contact/address_spec/suborganizations/suborganization/text()
 primary key(id, suborg_seq), 
 index(id));

create table wos.w127_reprint_addr_name (
 id int,
 names_seq int,
 name_addr_no int, 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/@addr_no
 dais_id varchar(50), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/@dais_id
 display	varchar(50), --	doc()/records/REC/static_data/item/reprint_contact/names/name/@display
 r_id varchar(50), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/@r_id
 reprint varchar(50), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/@reprint
 role varchar(50), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/@role
 seq_no int, 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/@seq_no
 full_name varchar(255), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/full_name/text()
 display_name varchar(255), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/display_name/text()
 email_addr varchar(255), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/email_addr/text()
 first_name varchar(255), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/first_name/text()
 last_name varchar(255), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/last_name/text()
 suffix varchar(255), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/suffix/text()
 wos_standard varchar(255), 	--	doc()/records/REC/static_data/item/reprint_contact/names/name/wos_standard/text()
 primary key(id, names_seq), 
 index(id));


create table wos.w128_reviewed_work (
 id int,
 reviewed_work_Q int, -- doc()/records/REC/static_data/item/reviewed_work/languages/@count
 reviewed_work_lang varchar(255), -- doc()/records/REC/static_data/item/reviewed_work/languages/language/text()
 rw_authors_Q int, -- doc()/records/REC/static_data/item/reviewed_work/rw_authors/@count
 rw_year varchar(255), -- doc()/records/REC/static_data/item/reviewed_work/rw_year/text()
 primary key(id), 
 index(rw_authors_Q));

create table wos.w128_rw_authors (
 id int,
 rw_authors_seq int, 
 rw_authors varchar(255), -- doc()/records/REC/static_data/item/reviewed_work/rw_authors/rw_author/text()
 primary key(id, rw_authors_seq), 
 index(id));

create table wos.w129_contributors (
 id int,
 contributor_seq int, 
 orcid_id varchar(255), -- doc()/records/REC/static_data/contributors/contributor/name/@orcid_id
 r_id varchar(255), -- doc()/records/REC/static_data/contributors/contributor/name/@r_id
 role varchar(255), -- doc()/records/REC/static_data/contributors/contributor/name/@role
 seq_no int, -- doc()/records/REC/static_data/contributors/contributor/name/@seq_no
 full_name varchar(255), -- doc()/records/REC/static_data/contributors/contributor/name/full_name/text()
 display_name varchar(255), -- doc()/records/REC/static_data/contributors/contributor/name/display_name/text()
 first_name varchar(255), -- doc()/records/REC/static_data/contributors/contributor/name/first_name/text()
 last_name varchar(255), -- doc()/records/REC/static_data/contributors/contributor/name/last_name/text()
 primary key(id, contributor_seq), 
 index(id));


create table wos.w130_identifiers (
 id int,
 identifier_seq int,
 type varchar(255), -- doc()/records/REC/dynamic_data/cluster_related/identifiers/identifier/@type
 identifier varchar(255), -- doc()/records/REC/dynamic_data/cluster_related/identifiers/identifier/@value
 primary key(id, identifier_seq), 
 index(id));


create table wos.w131_ic_related (
 id int,
 oases_Q int, -- doc()/records/REC/dynamic_data/ic_related/oases/@count
 oases_type varchar(25), -- doc()/records/REC/dynamic_data/ic_related/oases/oas/@type
 oas varchar(255), -- doc()/records/REC/dynamic_data/ic_related/oases/oas/text()
 primary key(id));
commit;


use wos;
-- drop table if exists wos.UIDs;
create table wos.UIDs (index(UID), index(id)) select x.UID,  replace(upper(x.file), '.XML', '') as file, x.loaded, x.id  from wos.rawXMLs x ;  commit;

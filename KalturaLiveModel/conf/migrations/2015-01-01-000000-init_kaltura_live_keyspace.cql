CREATE KEYSPACE IF NOT EXISTS kaltura_live WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 2 };

CREATE TABLE IF NOT EXISTS kaltura_live.log_files (
	hour_id timestamp,
	file_id text,
	PRIMARY KEY (hour_id, file_id)
)
WITH CLUSTERING ORDER BY (file_id DESC);

CREATE TABLE IF NOT EXISTS kaltura_live.log_data (
	file_id text PRIMARY KEY,
	data blob);

CREATE TABLE IF NOT EXISTS kaltura_live.live_events (
	entry_id text,
	event_time timestamp,
	plays bigint,
	alive bigint,
	dvr_alive bigint,
	bitrate bigint,
	bitrate_count bigint,
	buffer_time double,
	PRIMARY KEY (entry_id,event_time)
)
WITH CLUSTERING ORDER BY (event_time DESC);

CREATE TABLE IF NOT EXISTS kaltura_live.hourly_live_events (
	entry_id text,
	event_time timestamp,
	plays bigint,
	alive bigint,
	dvr_alive bigint,
	bitrate bigint,
	bitrate_count bigint,
	buffer_time double,
	PRIMARY KEY (entry_id,event_time)
)
WITH CLUSTERING ORDER BY (event_time DESC);

CREATE TABLE IF NOT EXISTS kaltura_live.live_events_location (
	entry_id text,
	event_time timestamp,
	country text,
	city text,
	plays bigint,
	alive bigint,
	dvr_alive bigint,
	bitrate bigint,
	bitrate_count bigint,
	buffer_time double,
	PRIMARY KEY ((entry_id,event_time), country, city));

CREATE TABLE IF NOT EXISTS kaltura_live.hourly_live_events_partner (
	partner_id int,
	event_time timestamp,
	plays bigint,
	alive bigint,
	dvr_alive bigint,
	bitrate bigint,
	bitrate_count bigint,
	buffer_time double,
	PRIMARY KEY (partner_id,event_time)
)
WITH CLUSTERING ORDER BY (event_time DESC);

CREATE TABLE IF NOT EXISTS kaltura_live.hourly_live_events_referrer (
	entry_id text,
	event_time timestamp,
	referrer text,
	plays bigint,
	alive bigint,
	dvr_alive bigint,
	bitrate bigint,
	bitrate_count bigint,
	buffer_time double,
	PRIMARY KEY ((entry_id,event_time), referrer));

CREATE TABLE IF NOT EXISTS kaltura_live.live_partner_entry (
	partner_id int,
	entry_id text,
	event_time timestamp,
	PRIMARY KEY (partner_id, entry_id));

CREATE TABLE IF NOT EXISTS kaltura_live.live_entry_hourly_peak (
	entry_id text,
	event_time timestamp,
	audience bigint,
	dvr_audience bigint,
	PRIMARY KEY (entry_id, event_time)
)
WITH CLUSTERING ORDER BY (event_time DESC);

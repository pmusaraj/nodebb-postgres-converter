DELETE FROM "classify"."unclassified" uc
 USING "classify"."analytics_errors" ae
 WHERE uc."_key" = 'analytics:errors:' || ae."http_status"
   AND uc."type" = 'zset'
   AND uc."unique_string" = (EXTRACT(EPOCH FROM ae."hour") * 1000)::TEXT
   AND uc."value_numeric" = ae."count"::NUMERIC;

DELETE FROM "classify"."unclassified" uc
 USING "classify"."analytics_flags" af
 WHERE uc."_key" = 'analytics:flags'
   AND uc."type" = 'zset'
   AND uc."unique_string" = (EXTRACT(EPOCH FROM af."hour") * 1000)::TEXT
   AND uc."value_numeric" = af."count"::NUMERIC;

DELETE FROM "classify"."unclassified" uc
 USING "classify"."analytics_pageviews" ap
 WHERE uc."_key" = 'analytics:pageviews'
   AND uc."type" = 'zset'
   AND uc."unique_string" = (EXTRACT(EPOCH FROM ap."hour") * 1000)::TEXT
   AND uc."value_numeric" = ap."count"::NUMERIC;

-- manually-maintained... view?
DELETE FROM "classify"."unclassified"
 WHERE "_key" = 'analytics:pageviews:month'
   AND "type" = 'zset';

DELETE FROM "classify"."unclassified" uc
 USING "classify"."analytics_pageviews_byCid" ap
 WHERE uc."_key" = 'analytics:pageviews:byCid:' || ap."cid"
   AND uc."type" = 'zset'
   AND uc."unique_string" = (EXTRACT(EPOCH FROM ap."hour") * 1000)::TEXT
   AND uc."value_numeric" = ap."count"::NUMERIC;
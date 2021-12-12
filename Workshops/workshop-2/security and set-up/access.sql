#Done by a special role
;

grant usage on schema "BEETLE_WORKSHOPS"."PUBLIC" TO ROLE TRAINING_ROLE;
grant select on table "BEETLE_WORKSHOPS"."PUBLIC"."STOCKS" TO ROLE TRAINING_ROLE;
CREATE OR REPLACE FUNCTION Convert2Meters(lengthInput double, InputScale string )
    RETURNS double
    LANGUAGE javascript
    AS
    $$
    /*
    *  convert English measurements to meters 
    */
    var scale_UC =  INPUTSCALE.toUpperCase();
    switch(scale_UC) {
    case 'INCH':
        return(LENGTHINPUT * 0.0254)
        break;
    case 'FEET':
        return(LENGTHINPUT * 0.3048)
        break;
    case 'YARD':
        return(LENGTHINPUT * 0.9144)
        break;

    default:
        return null;
        break; 
    }
  $$;

CREATE OR REPLACE FUNCTION order_cnt(custkey number(38,0))
  RETURNS number(38,0)
  AS 
  $$
    SELECT COUNT(1) FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS"WHERE o_custkey = custkey
  $$;
  
/* ***
*   ChangeWHSize(wh_name STRING, wh_size STRING)
*
* Description: Change a WH size to a new size. The size is limited to larger or below.

*/
create or replace procedure ChangeWHSize(wh_name STRING, wh_size STRING )
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    /*
    *  Change the named warehouse to a new size if the new size is LARGE OR smaller 
    */
    var wh_size_UC = WH_SIZE.toUpperCase();
    switch(wh_size_UC) {
    case 'XSMALL':
    case 'SMALL':
    case 'MEDIUM':
    case 'LARGE':
        break;
    case 'XLARGE':
    case 'X-LARGE':
    case 'XXLARGE':
    case 'X2LARGE':
    case '2X-LARGE':
    case 'XXXLARGE':
    case 'X3LARGE':
    case '3X-LARGE':
    case 'X4LARGE':
    case '4X-LARGE':
        return "Size: " + WH_SIZE + " is too large";
        break; 
    default:
        return "Size: " + WH_SIZE + " is not valid";
        break; 
    }
        
    var sql_command = 
     "ALTER WAREHOUSE IF EXISTS " + WH_NAME + " SET WAREHOUSE_SIZE = "+ WH_SIZE;
    try {
        snowflake.execute (
            {sqlText: sql_command}
            );
        return "Succeeded.";   // Return a success/error indicator.
        }
    catch (err)  {
        return "Failed: " + err;   // Return a success/error indicator.
        }
    $$
    ;
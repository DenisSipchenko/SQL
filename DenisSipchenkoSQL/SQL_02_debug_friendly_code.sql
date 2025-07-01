CREATE PROCEDURE pr_example_dbgFriendlyCREATE PROCEDURE pr_example_dbgFriendly
    (
    /*--------------------------------------------------------------
     *  imagine couple dozen parameters inside this block 
     *-------------------------------------------------------------*/ 
     in @dbg_CustomerId int DEFAULT NULL
    )
BEGIN       
    /*--------------------------------------------------------------
     *  imagine couple hundred lines of code inside this block 
     *-------------------------------------------------------------*/
    
    SELECT *
    /*--------------------------------------------------------------
     *  imagine couple hundred lines of code inside this block 
     *-------------------------------------------------------------*/
    FROM Customer c
    /*--------------------------------------------------------------
     *  imagine couple thousand lines of code inside this block 
     *-------------------------------------------------------------*/
    WHERE 1=1
        AND (  -- IF @dbg_CustomerId Not specified THEN this FILTER IS ignored              
               @dbg_CustomerId  =  c.CustomerId
            OR @dbg_CustomerId  IS NULL              
        );
    /*--------------------------------------------------------------
     *  imagine couple thousand lines of code inside this block 
     *-------------------------------------------------------------*/
END;

/*-- Default scenario - returns all customers ---------------------------*/
  CALL pr_example_dbgFriendly(@dbg_CustomerId = NULL);  -- syntax option 1 
--CALL pr_example_dbgFriendly(NULL);                    -- syntax option 2
--CALL pr_example_dbgFriendly();                        -- syntax option 3

/*-- Debug/Test mode scenario - return info for specified customer -----*/
  CALL pr_example_dbgFriendly(@dbg_CustomerId =  3  );  -- syntax option 1
--CALL pr_example_dbgFriendly(3);                       -- syntax option 2
  


SELECT HISTORY_ID, floor(DAILY_FEE * (100-DISCOUNT_RATE) / 100) * RENTAL_DAYS 'FEE'
FROM (
    SELECT
        H.HISTORY_ID 'HISTORY_ID'
        , C.DAILY_FEE 'DAILY_FEE' 
        , TIMESTAMPDIFF(DAY,START_DATE,END_DATE)+1 'RENTAL_DAYS'
        # , substring(DURATION_TYPE,1,instr(DURATION_TYPE,'일')-1) '비교대상'
        , MAX(if(TIMESTAMPDIFF(DAY,START_DATE,END_DATE)+1
        >= substring(DURATION_TYPE,1,instr(DURATION_TYPE,'일')-1),DISCOUNT_RATE,0)) 'DISCOUNT_RATE'
    FROM
        CAR_RENTAL_COMPANY_CAR C
        , CAR_RENTAL_COMPANY_RENTAL_HISTORY H
        , CAR_RENTAL_COMPANY_DISCOUNT_PLAN D
    WHERE
        C.CAR_ID = H.CAR_ID
        AND C.CAR_TYPE = D.CAR_TYPE
        AND C.CAR_TYPE = '트럭'
    GROUP BY
        HISTORY_ID
    ) T
ORDER BY 2 DESC, 1 DESC
;

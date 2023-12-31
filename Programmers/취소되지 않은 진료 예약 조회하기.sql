-- MySQL
SELECT 
    A.APNT_NO
    , P.PT_NAME
    , P.PT_NO
    , A.MCDP_CD
    , D.DR_NAME
    , A.APNT_YMD
FROM
    DOCTOR D
    , APPOINTMENT A
    , PATIENT P
WHERE
    D.DR_ID = A.MDDR_ID -- join
    AND A.PT_NO = P.PT_NO -- join
    AND DATE_FORMAT(A.APNT_YMD,'%Y%m%d') = '20220413'
    -- AND (YEAR(A.APNT_YMD) = 2022 AND MONTH(A.APNT_YMD) = 4 AND DAY(A.APNT_YMD) = 13)
    AND A.APNT_CNCL_YN = 'N'
    AND D.MCDP_CD = 'CS'
ORDER BY
    6 ASC
;

-- 임의 인덱스 구성
-- APPOINTMENT : [ APNT_YMD, MDDR_ID, PT_NO ]
-- DOCTOR : [ DR_ID, MCDP_CD ]
-- PATIENT : [ PT_NO ]

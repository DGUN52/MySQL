SELECT round(avg(lat_n),4)
FROM (SELECT row_number() over(order by lat_n) rn, lat_n from station) s
WHERE CASE
        WHEN (SELECT count(*) FROM station)%2 = 0
            THEN rn IN ((SELECT count(*)/2 FROM station), (SELECT count(*)/2 FROM station)+1)
        WHEN (SELECT count(*) FROM station)%2 = 1
            THEN rn = (SELECT count(*)/2 FROM station)+0.5
      END
;

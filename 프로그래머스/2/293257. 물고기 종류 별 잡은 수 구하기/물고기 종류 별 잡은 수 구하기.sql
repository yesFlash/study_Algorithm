# 잡은 물고기 FISH_INFO : 
# 물고기 이름 : FISH_NAME_INFO : 
# 종류별 물고기 이름과 잡은 수
SELECT COUNT(*) FISH_COUNT, FISH_NAME
FROM FISH_NAME_INFO N
    JOIN FISH_INFO I ON N.FISH_TYPE = I.FISH_TYPE
GROUP BY FISH_NAME
ORDER BY FISH_COUNT DESC;
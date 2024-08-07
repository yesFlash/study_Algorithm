# 자동차 정보 CAR_RENTAL_COMPANY_CAR 
#       // CAR_ID, // CAR_TYPE, DAILY_FEE, OPTIONS
#       자동차 ID, 자동차 종류, 일일 대여 요금(원), 자동차 옵션 리스트
# 대여 기록 CAR_RENTAL_COMPANY_RENTAL_HISTORY 
#       HISTORY_ID, // CAR_ID, START_DATE, END_DATE
#       자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일
# 종류별 기간별 할인 정보 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 
#       PLAN_ID, // CAR_TYPE, DURATION_TYPE, DISCOUNT_RATE
#       요금 할인 정책 ID, 자동차 종류, 대여 기간 종류, 할인율(%)

# # 조건에 해당하는 차에 대한 요금 테이블
# SELECT CAR_ID, C.CAR_TYPE, ROUND(DAILY_FEE*(100 - DISCOUNT_RATE)/100) FEE
# FROM CAR_RENTAL_COMPANY_CAR C
#     JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN P ON C.CAR_TYPE = P.CAR_TYPE
# WHERE DURATION_TYPE LIKE '30%' AND C.CAR_TYPE IN ('SUV', '세단');

# # 대여 불가능한 차
# SELECT CAR_ID, START_DATE, END_DATE
# FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
# WHERE START_DATE <= '2022-11-30' AND END_DATE >= '2022-11-01'
# ORDER BY CAR_ID;

SELECT CAR_ID, CAR_TYPE, FEE
FROM (
    SELECT CAR_ID, C.CAR_TYPE, ROUND(DAILY_FEE*(100 - DISCOUNT_RATE)/100)*30 FEE
    FROM CAR_RENTAL_COMPANY_CAR C
        JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN P ON C.CAR_TYPE = P.CAR_TYPE
    WHERE DURATION_TYPE LIKE '30%' AND C.CAR_TYPE IN ('SUV', '세단')
) FEE_TABLE
WHERE CAR_ID NOT IN (
    SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
    WHERE START_DATE <= '2022-11-30' AND END_DATE >= '2022-11-01'
    ORDER BY CAR_ID
)
    AND FEE >= 500000 AND FEE <2000000
ORDER BY FEE DESC, CAR_TYPE, CAR_ID DESC;
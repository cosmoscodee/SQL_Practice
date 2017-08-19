-- START WITH ~ CONNECT BY 절 Hierarchical QUERY

    SELECT LEVEL, MANAGER_ID, EMPLOYEE_ID
      FROM EMPLOYEES
START WITH MANAGER_ID IS NULL
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID                -- 기준이 되는 쪽이 왼쪽에 적어야함
  ORDER BY LEVEL, MANAGER_ID, EMPLOYEE_ID;


-- ROLLUP, CUBE
-- 부서별, 직책별 사원수, 평균 월급을 출력

  SELECT DEPARTMENT_ID,
         JOB_ID,
         COUNT (*),
         AVG (SALARY)
    FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID, JOB_ID;

--ROLLUP
  SELECT CASE GROUPING (DEPARTMENT_ID)                 -- 0 이면 그룹핑 된거, 1이면 안된거
            WHEN 1 THEN '모든 부서'
            ELSE NVL (TO_CHAR (DEPARTMENT_ID), '없음')
         END
            AS "부서",
         CASE GROUPING (JOB_ID)
            WHEN 1 THEN '모든 직책'
            ELSE NVL (TO_CHAR (JOB_ID), '업음')
         END
            AS "직책",
         COUNT (*),
         ROUND (AVG (SALARY)) AS "평균 월급"
    FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID, JOB_ID;


--CUBE
  SELECT CASE GROUPING (DEPARTMENT_ID)                 -- 0 이면 그룹핑 된거, 1이면 안된거
            WHEN 1 THEN '모든 부서'
            ELSE NVL (TO_CHAR (DEPARTMENT_ID), '없음')
         END
            AS "부서",
         CASE GROUPING (JOB_ID)
            WHEN 1 THEN '모든 직책'
            ELSE NVL (TO_CHAR (JOB_ID), '업음')
         END
            AS "직책",
         COUNT (*),
         ROUND (AVG (SALARY)) AS "평균 월급"
    FROM EMPLOYEES
GROUP BY CUBE (DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID, JOB_ID;

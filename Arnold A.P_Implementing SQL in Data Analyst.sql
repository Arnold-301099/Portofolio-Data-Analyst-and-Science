SELECT * FROM ds_salaries;

-- 1. Apakah ada data yang NULL?
SELECT * FROM ds_salaries 
WHERE work_year IS NULL
OR experience_level IS NULL
OR employment_type IS NULL
OR job_title IS NULL
OR salary IS NULL
OR salary_currency IS NULL
OR salary_in_usd IS NULL
OR employee_residence IS NULL
OR remote_ratio IS NULL
OR company_location IS NULL
OR company_size IS NULL;

-- 2. Melihat Job Title apa saja yang ada dalam table
SELECT DISTINCT job_title FROM ds_salaries ORDER BY job_title;

-- 3. Job Title yang berkaitan dengan Data Analyst
SELECT DISTINCT job_title FROM ds_salaries WHERE job_title LIKE '%data analyst%' ORDER BY job_title;

-- 4. Rata-rata gaji Data Analyst dalam rupiah selama sebulan
SELECT (AVG(salary_in_usd) * 15000) / 12 AS avg_sal_rp_monthly FROM ds_salaries;

-- 5. Rata-rata gaji Data Analyst berdasarkan experience levelnya dan jenis pegawainya
SELECT experience_level, employment_type, (AVG(salary_in_usd) * 15000) / 12 
	AS avg_sal_rp_monthly FROM ds_salaries GROUP BY experience_level, employment_type ORDER BY experience_level, employment_type;

-- 6. Negara dengan gaji rata-rata >= 20000 USD di banding negara lain dengan posisi Data Analyst dengan paruh waktu Full Time
SELECT company_location, AVG(salary_in_usd) AS avg_sal_in_usd FROM ds_salaries WHERE job_title LIKE '%data analyst%' AND employment_type = 'FT' AND experience_level IN ('MI', 'EN') GROUP BY company_location HAVING avg_sal_in_usd >= 20000;

-- 7. Kenaikan gaji paling tinggi dari posisi mid ke senior di tahun berapa untuk pekerjaan yang berhubungan dengan Data Analyst
WITH ds_1 AS ( 
	SELECT work_year, 
		AVG(salary_in_usd) AS sal_in_usd_ex 
		FROM ds_salaries 
	WHERE employment_type = 'FT' 
		AND experience_level = 'EX' 
		AND job_title LIKE '%data analyst%' 
	GROUP BY work_year
), 
ds_2 AS ( 
	SELECT work_year, 
		AVG(salary_in_usd) AS sal_in_usd_mi 
	FROM ds_salaries 
	WHERE employment_type = 'FT' 
		AND experience_level = 'MI' 
		AND job_title LIKE '%data analyst%' 
	GROUP BY work_year
        ), t_year AS (
				SELECT DISTINCT work_year
                FROM ds_salaries
        ) SELECT t_year.work_year,
			ds_1.sal_in_usd_ex, 
			ds_2.sal_in_usd_mi, 
            ds_1.sal_in_usd_ex - ds_2.sal_in_usd_mi differences
        FROM t_year
        LEFT JOIN ds_1 ON ds_1.work_year = t_year.work_year
        LEFT JOIN ds_2 ON ds_2.work_year = t_year.work_year;
WITH HOUSEHOLDS AS (
    SELECT DISTINCT UPRN_BLPU, Parent_UPRN_BLPU, BLPU_Class_BLPU, BLPU_Class_BLPU_Desc, Name_LPI, Secondary_Name_LPI,
		Address_LPI, Postcode_LPI, Start_Date_LPI, End_Date_LPI
    FROM dbo.BLPU
	WHERE Non_Postal_LPI = 'F'
		AND BLPU_CLASS_BLPU NOT LIKE 'P%'
	AND (Parent_UPRN_BLPU is NULL 
		or 
		Parent_UPRN_BLPU IN (SELECT UPRN_BLPU FROM dbo.BLPU WHERE BLPU_Class_BLPU LIKE 'P%')
		)
	AND Postcode_LPI is not null 
	AND BLPU_CLASS_BLPU LIKE 'R%'
	--and BLPU_CLASS_BLPU NOT IN ('RG', 'RG02', 'RH02', 'RH03')
		--(BLPU_CLASS_BLPU LIKE 'C%' 
		--or BLPU_CLASS_BLPU LIKE 'R%'
		--or BLPU_CLASS_BLPU LIKE 'X%' 
		--or BLPU_CLASS_BLPU LIKE 'ZS%'
		--or BLPU_CLASS_BLPU LIKE 'ZW%'
		--or BLPU_CLASS_BLPU = 'OR04') 
	AND Logical_Status_BLPU = 1 
	AND (BLPU_State_BLPU is NULL or BLPU_State_BLPU = 2)
	--AND (End_Date_BLPU IS NULL or End_Date_BLPU > '2022-01-01') 
)
SELECT Postcode_LPI, COUNT(Postcode_LPI) as Postcode_count --DISTINCT Secondary_Name_LPI --, Start_Date_LPI, End_Date_LPI, Start_Date_BLPU, End_Date_BLPU
FROM HOUSEHOLDS
WHERE Start_Date_LPI < '2021-01-01' AND (End_Date_LPI IS NULL or End_Date_LPI > '2021-01-01')
GROUP BY Postcode_LPI
;


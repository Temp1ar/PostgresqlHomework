-- 1. ¬се совершеннолетние флатландцы без прививок
SELECT c.id, c.fullname FROM citizen c
LEFT JOIN citizen_vaccinated cv ON cv.citizen_id = c.id
WHERE age(birth_date) > interval '18 years'
GROUP BY c.id, c.fullname
HAVING COUNT(cv.*) = 0
ORDER BY c.id

-- 2. —писок болезней которые вырабатывают иммунитет, и от которых нет вакцины
SELECT d.id, d.name FROM disease d
LEFT JOIN vaccination_from vf ON d.id = vf.disease_id
WHERE d.immunity_id IS NOT NULL
GROUP BY d.id, d.name
HAVING COUNT (vf.vaccination_id) = 0

-- 3. ‘латландцы, которые не болели
SELECT c.id, c.fullname FROM citizen c
LEFT JOIN citizen_has_disease chd ON chd.citizen_id = c.id
GROUP BY c.id, c.fullname
HAVING COUNT(chd.disease_id) = 0
ORDER BY c.id

-- 4. —ама€ смертельна€ болезнь
SELECT d.id, d.name, COUNT(chd.citizen_id) as cnt FROM citizen_has_disease chd
LEFT JOIN disease d ON chd.disease_id = d.id
WHERE chd.cause_death = true
GROUP BY d.id, d.name
ORDER BY cnt DESC
LIMIT 1

-- 5. —ама€ попул€рна€ болезнь в выбранный день, в этом примере это день '12-05', 5 декабр€

SELECT chd.disease_id, d.name, COUNT(chd.citizen_id) AS cnt FROM citizen_has_disease chd
LEFT JOIN disease d ON chd.disease_id = d.id
WHERE ('1970-' || '12-05')::date BETWEEN 
 ('1970-' || EXTRACT('month' FROM begin_date) || '-' || EXTRACT('day' FROM begin_date))::date
 AND 
 ( 1970 + EXTRACT('year' FROM end_date) - EXTRACT('year' FROM begin_date) || '-' || EXTRACT('month' FROM end_date) || '-' || EXTRACT('day' FROM end_date))::date
GROUP BY chd.disease_id, d.name, chd.citizen_id
ORDER BY cnt DESC
LIMIT 1

--6. —ама€ попул€рна€ прививка
SELECT cv.vaccination_id, v.name, COUNT(cv.*) as cnt FROM citizen_vaccinated cv
LEFT JOIN vaccination v ON v.id = cv.vaccination_id
GROUP BY cv.vaccination_id, v.name
ORDER BY cnt DESC
LIMIT 1

--7. —редн€€ продолжительность лечени€ дл€ каждой болезни
SELECT chd.disease_id, d.name,
AVG(CASE WHEN end_date IS NULL THEN CURRENT_DATE-begin_date ELSE end_date-begin_date END) as days_infected 
FROM citizen_has_disease chd
LEFT JOIN disease d ON chd.disease_id = d.id
GROUP BY chd.disease_id, d.name

--8. ” жител€ есть иммунитет от всего, от чего он может быть
SELECT c.id, c.fullname FROM (
	(SELECT c.id as id, c.fullname as fullname, i.id as immunity_id FROM citizen c 
	JOIN citizen_has_disease chd ON c.id = chd.citizen_id
	JOIN disease_gives_immunity dgi on chd.record_id = dgi.record_id
	JOIN immunity i ON dgi.immunity_id = i.id)
	UNION (
	SELECT c.id as id, c.fullname as fullname, i.id as immunity_id FROM citizen c 
	JOIN citizen_vaccinated cv ON c.id = cv.citizen_id
	JOIN vaccination_gives_immunity vgi on cv.record_id = vgi.record_id
	JOIN immunity i ON vgi.immunity_id = i.id)
) as c 
GROUP BY c.id, c.fullname
HAVING COUNT(c.immunity_id) = (
	SELECT COUNT(*) FROM disease WHERE immunity_id IS NOT NULL
)

--9* Ёпидемии в истории ‘латландии. дни в которые нек. болезнью болело больше 50% населени€
SELECT aday, did , COUNT(citizen_id) FROM 
	(SELECT ((SELECT MIN(begin_date) FROM citizen_has_disease ) + s.a) as aday, 
		d.id as did
	FROM generate_series( 
	0,
	(SELECT MAX(end_date)-MIN(begin_date)+1 FROM citizen_has_disease),
	1) as s(a), disease d) 
AS alls
JOIN citizen_has_disease chd ON (
	((alls.aday, alls.aday) OVERLAPS (chd.begin_date, chd.end_date))
	AND chd.citizen_id = alls.did
)
GROUP BY alls.did, alls.aday
HAVING COUNT(citizen_id) > (SELECT COUNT(*)/2 FROM citizen)

--10* ‘латландец, который болел каждый день в последнем году
SELECT alls.cid, COUNT(alls.aday) FROM (
	SELECT aday, c.id as cid FROM 
		(SELECT 
			((EXTRACT(YEAR FROM CURRENT_DATE)-1 || '-01-01')::date + s.a) as aday	
		FROM generate_series(0,	365, 1) as s(a)) 
	AS alls, citizen c) as alls
JOIN citizen_has_disease chd ON (chd.citizen_id = alls.cid AND ((alls.aday, alls.aday) OVERLAPS (chd.begin_date, chd.end_date)))
GROUP BY alls.cid
HAVING COUNT(alls.aday) > 364
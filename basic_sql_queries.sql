-- retrieving info from bookings, facilities, and members 

SELECT * FROM cd.bookings
SELECT * FROM cd.members
SELECT * FROM cd.facilities

-- members only cost for different facilities 
SELECT name, membercost FROM cd.facilities;

-- list of facilities that are free of cost to members 
SELECT name FROM cd.facilities
WHERE membercost = 0;

-- list of facilities with word 'tennis' in their name 

SELECT * FROM cd.facilities
WHERE name ILIKE '%tennis%';

-- list of members who joined after august 2012. 
SELECT * FROM cd.members 
WHERE joindate > '2012-08-31 23:59:59';

-- ordered list of 10 surnames in members table without duplicates 
SELECT DISTINCT(surname) FROM cd.members 
ORDER BY surname 
LIMIT 10;

-- signup date/join date of last member 
SELECT joindate, firstname, surname FROM cd.members 
ORDER BY joindate DESC
LIMIT 1;

-- number of facilities with guest cost 10 or more 
SELECT COUNT(*) FROM cd.facilities 
WHERE guestcost >= 10;

-- list of 10 members who have joined the earliest. 
SELECT * FROM cd.members 
ORDER BY joindate 
LIMIT 10;

-- count the numbers of members who were recommended by prev members 

SELECT COUNT(*) FROM cd.members
WHERE recommendedby IS NOT NULL;

-- list of members with odd member IDs who have booked facilities  
SELECT firstname, surname, memid 
FROM cd.members 
WHERE memid IN (
SELECT memid FROM cd.bookings WHERE memid%2!= 0
);



-- list of total number of slots booked per facility in september 2012

SELECT facid, SUM(slots) AS Total_bookings 
FROM cd.bookings 
WHERE starttime>='2012-09-01' AND starttime<='2012-10-01'
GROUP BY facid 
ORDER BY SUM(slots);


-- list of facilities with more than 1000 bookings 
SELECT facid, SUM(slots) AS total_bookings
FROM cd.bookings 
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid;


-- list of start times for bookings for tennis courts for date '2012-09-15'

SELECT cd.facilities.name, cd.bookings.starttime 
FROM cd.facilities 
INNER JOIN cd.bookings 
ON cd.facilities.facid = cd.bookings.facid
WHERE cd.bookings.starttime 
BETWEEN '2012-09-15 00:00:00' 
AND '2012-09-15 23:59:59'
AND cd.facilities.name ILIKE '%TENNIS%COURT%'
ORDER BY cd.bookings.starttime;

-- list of starttime for bookings by 'Jack Smith '

SELECT cd.bookings.starttime, cd.facilities.name FROM cd.bookings 
INNER JOIN cd.members 
ON cd.bookings.memid = cd.members.memid 
INNER JOIN cd.facilities 
ON cd.facilities.facid = cd.bookings.facid
WHERE cd.members.firstname = 'Jack' AND cd.members.surname = 'Smith'
ORDER BY cd.bookings.starttime; 

-- list of members who have made more than 100 bookings. 
SELECT cd.bookings.memid, cd.members.firstname, cd.members.surname, COUNT(bookid) AS total_bookings
FROM cd.bookings 
INNER JOIN cd.members 
ON cd.members.memid = cd.bookings.memid
GROUP BY cd.bookings.memid, cd.members.firstname, cd.members.surname
HAVING COUNT(*)>100
ORDER BY COUNT(*); 

-- cost incurred by a member with memid = 10 
SELECT SUM(membercost) AS total_spent 
FROM cd.facilities 
INNER JOIN cd.bookings
ON cd.facilities.facid = cd.bookings.facid
WHERE memid = 10; 

-- retrieve all the facilities that have not been booked.

SELECT * FROM cd.facilities 
WHERE facid NOT IN(SELECT DISTINCT facid FROM cd.bookings);

-- list of members along with the facilities they've booked and total number of bookings

SELECT cd.bookings.memid,cd.members.firstname, cd.members.surname, COUNT(bookid)
FROM cd.bookings
INNER JOIN cd.members 
ON cd.members.memid = cd.bookings.memid
GROUP BY cd.bookings.memid,cd.members.firstname, cd.members.surname
ORDER BY cd.bookings.memid;

-- retrieve members who have spent more than $200 in total.  
SELECT firstname, surname, cd.members.memid, result.total_cost
FROM cd.members
INNER JOIN
(SELECT DISTINCT(cd.bookings.memid), SUM(cd.facilities.membercost) as total_cost
FROM cd.facilities
INNER JOIN cd.bookings
ON cd.bookings.facid = cd.facilities.facid 
GROUP BY cd.bookings.memid
HAVING SUM(cd.facilities.membercost)>200) AS result
ON cd.members.memid = result.memid 
ORDER BY result.total_cost DESC


-- list of facilities that have been booked x times 
SELECT cd.facilities.name, cd.facilities.facid, subtable.total_times_booked 
FROM cd.facilities
INNER JOIN
(SELECT DISTINCT(cd.bookings.facid) AS facilities, COUNT(cd.bookings.bookid) AS total_times_booked
FROM cd.bookings
GROUP BY cd.bookings.facid) AS subtable
ON cd.facilities.facid = subtable.facilities 
ORDER BY subtable.total_times_booked DESC












































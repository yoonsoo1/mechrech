DROP DATABASE IF EXISTS MechRec;
CREATE DATABASE IF NOT EXISTS MechRec;
use MechRec;

CREATE TABLE IF NOT EXISTS Users(
	email VARCHAR(100) UNIQUE NOT NULL,
    userID VARCHAR(20) NOT NULL,
    hashPass VARCHAR(20) NOT NULL,
    PRIMARY KEY(userID)
);

CREATE TABLE IF NOT EXISTS Companies (
	CompanyID INT UNIQUE NOT NULL,
    CompanyName VARCHAR(100) NOT NULL,
    rating DOUBLE,
    phone VARCHAR(13),
    address VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Posts (
	postID INT AUTO_INCREMENT,
    CompanyID INT NOT NULL,
    userID VARCHAR(20) NOT NULL,
    postMessage VARCHAR(255) NOT NULL,
    postTimestamp DATETIME NOT NULL DEFAULT(GETDATE()),
    rating DOUBLE NOT NULL,
    carModel VARCHAR(30) NOT NULL,
    carMake VARCHAR(30) NOT NULL,
    carYear INT NOT NULL,
    photo mediumblob,
    FOREIGN KEY(CompanyID) REFERENCES Companies(CompanyID),
    PRIMARY KEY (postID)
);

CREATE TABLE IF NOT EXISTS Services(
	serviceName VARCHAR(50) NOT NULL,
    CompanyID INT UNIQUE NOT NULL,
    price DOUBLE NOT NULL,
    postID INT NOT NULL,
    FOREIGN KEY(CompanyID) REFERENCES Companies(CompanyID),
    FOREIGN KEY (postID) REFERENCES Posts(postID)
);

CREATE TABLE IF NOT EXISTS Comments (
	message VARCHAR(150) NOT NULL,
    commentID INT AUTO_INCREMENT,
    commentTimestamp DATETIME NOT NULL,
    userID VARCHAR(10) NOT NULL,
    postID INT NOT NULL,
    FOREIGN KEY (postID) REFERENCES Posts(postID),
	PRIMARY KEY (commentID)
);

INSERT INTO Companies (CompanyID, CompanyName, rating, phone, address)
VALUES (1, "University Tire & Auto Service", 4.6, "323-733-1236", "2908 Vermont Ave, Los Angeles, CA 90007"),
	(2, "USC Smog Test Only Center", 4.9, "213-605-1955", "3000 S Figueroa St, Los Angeles, CA 90007"),
	(3, "Vermont Auto Center", 4.5, "323-730-0255", "2241 Vermont Ave, Los Angeles, CA 90007"),
	(4, "Midas", 3.6, "213-255-3006", "2424 S Figueroa St, Los Angeles, CA 90007"),
	(5, "Mario Automotive", 4.2, "213-744-9842", "201 W 31st St, Los Angeles, CA 90007"),
	(6, "LA Auto Repair", 4.4, "323-846-9188", "4088 S Figueroa St, Los Angeles, CA 90037"),
	(7, "Orion Auto Service", 4.9, "323-732-4669", "2217 Normandie Ave, Los Angeles, CA 90007"),
	(8, "Morales' Auto Repair", 4.0, "323-733-8380", "1424 W Jefferson Blvd, Los Angeles, CA 90007"),
	(9, "Union Auto Repair", 4.0, "213-484-1600", "3210 W. Olympic Blvd Los Angeles, CA 90006"),
	(10, "Figueroa's Auto Repair", 5.0, "323-707-6728", "5338 S Figueroa St, Los Angeles, CA 90037"),
	(11, "United Auto Center", 4.4, "323-733-7047", "2945 S Western Ave, Los Angeles, CA 90018"),
	(12, "Volkswagen of Downtown LA Service Center", 3.7, "213-725-5057", "1900 S Figueroa St A, Los Angeles, CA 90007"),
	(13, "King's Auto Tech Inc", 3.0, "323-293-1505", "1515 W Martin Luther King Jr Blvd, Los Angeles, CA 90062"),
	(14, "Felix Chevrolet", 3.7, "213-290-1925", "3330 S Figueroa St, Los Angeles, CA 90007"),
	(15, "Ortix Junior Auto Repair", 4.5, "323-299-8663", "1277 W Vernon Ave, Los Angeles, CA 90037"),
	(16, "Chicho's Auto Center", 4.8, "323-232-6488", "3700 S Avalon Blvd, Los Angeles, CA 90011"),
	(17, "L.A. Smog Center", 4.2, "213-745-5879", "3671 S Grand Ave, Los Angeles, CA 90007"),
	(18, "Pep Boys", 3.7, "213-749-1594", "3000 S Figueroa St, Los Angeles, CA 90007"),
	(19, "Auto Body and Paint Services", 2.5, "213-749-4672", "3701 Flower St, Los Angeles, CA 90007"),
	(20, "AutoZone Auto Parts", 4.2, "323-734-7467", "2907 S Vermont Ave, Los Angeles, CA 90007"),
	(21, "Ruiz Automotive & Engine Rebuild", 3.9, "323-758-3486", "5410 Normandie Ave, Los Angeles, CA 90037"),
	(22, "Yosemite Auto Body", 4.6, "323-737-2272", "1923 Vermont Ave, Los Angeles, CA 90007"),
	(23, "Ron's Auto", 5.0, "213-536-5707", "400 E Adams Blvd, Los Angeles, CA 90011"),
	(24, "Carlos Auto & Truck Services", 5.0, "323-526-7367", "3050 E Olympic Blvd, Los Angeles, CA 90023"),
	(25, "Mechanic Specialists", 4.0, "323-719-8014", "638 E. Washington Blvd, Adair St, Los Angeles, CA 90015"),
	(26, "Harvard Auto Repair", 4.3, "323-733-9996", "2921 W Pico Blvd, Los Angeles, CA 90006"),
	(27, "Innovative Auto Collision", 4.6, "323-432-2277", "4061 S Broadway, Los Angeles, CA 90037"),
	(28, "Ernests German Auto Repair", 4.4, "323-292-6773", "4600 S Western Ave, Los Angeles, CA 90062"),
	(29, "Mechanic Shop", 4.0, "310-962-8973", "1417 W Washington Blvd, Los Angeles, CA 90007"),
	(30, "Network Auto Body", 3.9, "323-232-8800", "3917 S Broadway, Los Angeles, CA 90037");
	
INSERT INTO Posts (CompanyID, userID, postMessage, rating)
Values (1, "David Andrew", "My girl's tires popped so we took the wheels and had the tires replaced. Can't remember names but the dude that helped us was nice and the job was well done.", 5.0),
	(1, "Kevin Cho", "Went in for tire checkup and repair on 8/13. Service was quick within 20 mins and each rep and mechanic was highly professional and friendly. Clean, uncluttered, and organized. I'm definitely going back if I ever need more services in the future.", 5.0),
	(1, "Elizabeth Quinn", "Needed a knob replacement on my manual transmission shift stick. The folks were able to make the replacement work and I was amazed at how quickly they got the job done. Super friendly, professional crew with integrity. Will definitely use them again!", 5.0),
	(1, "Morgan Lumpkins", "Excellent service, Diante, David, all of the employees are very professional and consistent in making sure your vehicle is serviced properly. I highly recommend University Tire & Auto Service. you will not be disappointed.", 5.0),
	(2, "Robert Donahoo", "Absolutely the best place for a Smog Test. Total testing is $50 cash, $52 if paying with a card. The process takes about 15 minutes to complete.  There’s no retests here so a word of caution. Best time to come out is mid-week in the morning.", 5.0),
	(2, "Launtie Jimenez", "Nice place to get your smog.", 4.0),
	(2, "Sharon Smith", "USC smog is an excellent place to have a smog test and very honest  business man of integrity. I've been a return customer because of his courteous service.", 5.0),
	(2, "Tony Bell", "This little shop is a hidden gem. I've been coming here for over 10 yrs. The is never a long wait and the owner / mechanic is a great guy with a greater personality.", 5.0),
	(3, "Thelma Waters", "The guy tells me over the phone that it will be $100-$200 just to put the car on a diagnostic machine, but previously he told me it’d be $100-$300 just to check my car. Don’t trust this place because they’re rip offs and they overprice people.", 1.0),
	(3, "Jaime Alberto Ortiz", "Nothing to complain about it, Mr. Young did a great job replacing my car’s throttle and doing general service to it. Good job!", 5.0),
	(3, "Jesse Walker", "I called to get a quote and they were able to get me in that day. I was worried I was being upsold when I agreed to additional work on site, but they still came in at the quoted price.", 5.0),
	(3, "Daija Marrow", "I love this place. They're nice, fast, and reliable. The price is never too high and I'm glad I found them. Would highly recommend.", 5.0),
	(4, "Juan Jose", "Heard a weird noise so stopped by, turns out front bumper lose, no mechanical problems. Jose was very helpful in determining true issue. Definitely will come back if work needed.", 5.0),
	(4, "Jack Vega", "The guys here are always super cool and get the job done on time or earlier. Highly recommend this place! Ditch those weird neighborhood mechanics and just come here! That's what I did", 5.0),
	(4, "Sade Dickenson", "Very reliable place. Excellent customer service. The worker Eric is very professional and does an excellent job with customer service and getting the work done safely and correctly. Thank you for your service.", 5.0),
	(4, "Jose Noguera", "I brought my car for a regular oil change and to cfix what was causing what lights to flash, in 3 days they had my car ready, two days later am back with the same electric problem, not what I expected from a place like this.", 1.0);


SET GLOBAL local_infile = 'ON';

UPDATE Companies c
SET c.rating = (SELECT AVG(p.rating) FROM Posts p
				WHERE c.companyID = p.companyID);
                show global variables like 'local_infile';
LOAD DATA LOCAL INFILE '/usr/local/mysql-8.0.27-macos11-x86_64/company.CSV' INTO TABLE Companies
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n';
LOAD DATA LOCAL INFILE '/usr/local/mysql-8.0.27-macos11-x86_64/reviews.CSV' INTO TABLE Posts
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n';
SELECT * From Companies;
SELECT * FROM Posts;

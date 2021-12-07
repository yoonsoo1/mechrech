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

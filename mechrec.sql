DROP DATABASE IF EXISTS MechRec;
CREATE DATABASE IF NOT EXISTS MechRec;
use MechRec;

CREATE TABLE IF NOT EXISTS Users(
	email VARCHAR(100) UNIQUE NOT NULL,
    userID VARCHAR(20) NOT NULL,
    hashPass VARCHAR(100) NOT NULL,
    saltHashPass INT NOT NULL,
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

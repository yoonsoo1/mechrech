CREATE DATABASE IF NOT EXISTS MechRec;

use MechRec;

CREATE TABLE IF NOT EXISTS Users(
	email VARCHAR(100) UNIQUE NOT NULL,
    userID VARCHAR(10) NOT NULL,
    hashPass VARCHAR(100) NOT NULL,
    saltHashPass INT NOT NULL,
    PRIMARY KEY(userID)
);

CREATE TABLE IF NOT EXISTS Companies (
	CompanyID INT UNIQUE NOT NULL,
    CompanyName VARCHAR(100) NOT NULL,
    rating DOUBLE,
    phone VARCHAR(10),
    address VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Posts (
	postID INT AUTO_INCREMENT,
    CompanyID INT UNIQUE NOT NULL,
    userID VARCHAR(10) NOT NULL,
    postMessage VARCHAR(255) NOT NULL,
    postTimestamp DATETIME NOT NULL,
    rating DOUBLE NOT NULL,
    carModel VARCHAR(30) NOT NULL,
    carMake VARCHAR(30) NOT NULL,
    carYear INT NOT NULL,
    img VARCHAR(100),
    FOREIGN KEY(CompanyID) REFERENCES Companies(CompanyID),
    FOREIGN KEY (userID) REFERENCES Users(userID),
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

UPDATE Companies c
SET c.rating = (SELECT AVG(p.rating) FROM Posts p
				WHERE c.companyID = p.companyID);

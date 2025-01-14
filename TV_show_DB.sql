-- Table: Account
CREATE TABLE Account (
    AccountID INT PRIMARY KEY,
    Username VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(50),
    Fullname VARCHAR(50),
    Address VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Role VARCHAR(20),
    Status BIT,
    CreatedAt DATETIME,
    UpdatedAt DATETIME
);

-- Table: SchoolChannel
CREATE TABLE SchoolChannel (
    SchoolChannelID INT PRIMARY KEY,
    AccountID INT,
    ChannelName VARCHAR(100),
    Description VARCHAR(255),
    Website VARCHAR(255),
    Email VARCHAR(255),
    Address VARCHAR(255),
    CreatedAt DATETIME,
    UpdatedAt DATETIME,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- Table: News
CREATE TABLE News (
    NewsID INT PRIMARY KEY,
    SchoolChannelID INT,
    Title VARCHAR(255),
    Content TEXT,
    CreatedAt DATETIME,
    UpdatedAt DATETIME,
    Status VARCHAR(10),
    FOREIGN KEY (SchoolChannelID) REFERENCES SchoolChannel(SchoolChannelID)
);

-- Table: Schedule
CREATE TABLE Schedule (
    ScheduleID INT PRIMARY KEY,
    StartTime DATETIME,
    EndTime DATETIME,
    Status VARCHAR(5)
);

-- Table: Program
CREATE TABLE Program (
    ProgramID INT PRIMARY KEY,
    ProgramName VARCHAR(100),
    Title VARCHAR(100),
    Link NVARCHAR(MAX),
    Status VARCHAR(50),
    ScheduleID INT,
    ChannelID INT,
    FOREIGN KEY (ScheduleID) REFERENCES Schedule(ScheduleID),
    FOREIGN KEY (ChannelID) REFERENCES SchoolChannel(SchoolChannelID)
);

-- Table: VideoHistory
CREATE TABLE VideoHistory (
    VideoHistoryID INT PRIMARY KEY,
    ProgramID INT,
    URL VARCHAR(255),
    Type VARCHAR(50),
    Description VARCHAR(255),
    Status VARCHAR(50),
    CreatedAt DATETIME,
    StreamAt DATETIME,
    FOREIGN KEY (ProgramID) REFERENCES Program(ProgramID)
);

-- Table: VideoView
CREATE TABLE VideoView (
    ViewID INT PRIMARY KEY,
    VideoHistoryID INT,
    Quantity INT,
    FOREIGN KEY (VideoHistoryID) REFERENCES VideoHistory(VideoHistoryID)
);

-- Table: VideoLike
CREATE TABLE VideoLike (
    LikeID INT PRIMARY KEY,
    AccountID INT,
    VideoHistoryID INT,
    Quantity INT,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (VideoHistoryID) REFERENCES VideoHistory(VideoHistoryID)
);

-- Table: Share
CREATE TABLE Share (
    ShareID INT PRIMARY KEY,
    AccountID INT,
    VideoHistoryID INT,
    Quantity INT,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (VideoHistoryID) REFERENCES VideoHistory(VideoHistoryID)
);

-- Table: Comment
CREATE TABLE Comment (
    CommentID INT PRIMARY KEY,
    AccountID INT,
    VideoHistoryID INT,
    Content VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (VideoHistoryID) REFERENCES VideoHistory(VideoHistoryID)
);

-- Table: Report
CREATE TABLE Report (
    ReportID INT PRIMARY KEY,
    AccountID INT,
    VideoHistoryID INT,
    Reason NVARCHAR(MAX),
    CreatedAt DATETIME,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (VideoHistoryID) REFERENCES VideoHistory(VideoHistoryID)
);

-- Table: [Order]
CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY,
    AccountID INT,
    TotalPrice DECIMAL,
    Status VARCHAR(20),
    CreatedAt DATETIME,
    UpdatedAt DATETIME,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

-- Table: Payment
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    SchoolID INT,
    PaymentMethod VARCHAR(50),
    Amount DECIMAL,
    Status VARCHAR(20),
    PaymentDate DATETIME,
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID)
);

-- Table: Package
CREATE TABLE Package (
    PackageID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description VARCHAR(255),
    Price DECIMAL,
    Duration INT,
    Status VARCHAR(20),
    CreatedAt DATETIME,
    UpdatedAt DATETIME
);

-- Table: OrderDetail
CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    PackageID INT,
    Quantity INT,
    Price DECIMAL,
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    FOREIGN KEY (PackageID) REFERENCES Package(PackageID)
);

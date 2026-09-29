ALTER TABLE [Wallets]
ADD CONSTRAINT FK_Wallets_UserID_Users_UserID FOREIGN KEY (UserID)
REFERENCES Users(UserID);

ALTER TABLE [Wallets]
ADD CONSTRAINT FK_Wallets_CurrencyID_CurrencyTypes_CurrencyID FOREIGN KEY (CurrencyID)
REFERENCES CurrencyTypes(CurrencyID);

ALTER TABLE [Transactions]
ADD CONSTRAINT FK_Transactions_UserID_Users_UserID FOREIGN KEY (UserID)
REFERENCES Users(UserID);

ALTER TABLE [Transactions]
ADD CONSTRAINT FK_Transactions_CurrencyID_CurrencyTypes_CurrencyID FOREIGN KEY (CurrencyID)
REFERENCES CurrencyTypes(CurrencyID);

insert into [] () values ();


select*from Transactions;

select*from Wallets;


truncate table Wallets;

truncate table Transactions;


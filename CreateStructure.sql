CREATE TABLE dbo.SKU
(
	ID INT Primary key identity(1,1),
	Code as Concat('s', ID),
	Name varchar(255) not null,
	Constraint unq_name Unique(Code)
)
CREATE TABLE dbo.Family
(
	ID int Primary key identity(1,1),
	SurName varchar(255) not null,
	BudgetValue int not null,
	Constraint CK_Family_BudgetValue_lees_than_zero Check(BudgetValue >= 0)
)
CREATE TABLE dbo.Basket
(
	ID int primary key identity(1,1),
	ID_SKU int not null,
	ID_Family int null,
	Quantity int not null,
	Value int not null,
	PurchaseDate datetime DEFAULT GETDATE(),
	DiscountValue int not null,
	Constraint FK_Basket_SKU_ID Foreign key(ID_SKU) references dbo.SKU(ID)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	Constraint FK_Basket_Family_ID Foreign key(ID_Family) references dbo.Family(ID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	Constraint CK_Basket_Quantity_lees_than_zero Check(Quantity >= 0),
	Constraint CK_Basket_Value_lees_than_zero Check(Value >= 0)
)
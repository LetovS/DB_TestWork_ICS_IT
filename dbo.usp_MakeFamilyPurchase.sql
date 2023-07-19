create proc usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
	as
	begin
		begin transaction 
			set nocount on
			-- Try catch situation if constaint is not found
			begin try
			alter table [dbo].[Basket]
			drop constraint FK_Basket_Family_ID
			end try
			begin catch
				Print('FK_constraint not found')
			end catch

			if(Exists(select * from dbo.Family where SurName = @FamilySurName))
				begin
				Declare @ID_Family as int
				select @ID_Family = ID From dbo.Family where SurName = @FamilySurName
				UPDATE dbo.Family
				SET BudgetValue = dbo.Family.BudgetValue - (select Sum(Value*Quantity) FROM dbo.Basket where ID_Family = @ID_Family)
				Where SurName = @FamilySurName
				end
			else
				Throw 51000, 'Current family not found', 1;

			alter table [dbo].[Basket]
			add constraint FK_Basket_Family_ID Foreign key([ID_Family]) references [dbo].[Family](ID)

		Commit
	end
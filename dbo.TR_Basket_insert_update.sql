create trigger trg_Basket_insert_two_or_more_records on dbo.Basket 
after insert 
as  
begin	
	update dbo.Basket
	set DiscountValue = value * 0.05
	Where ID in (select Id from inserted where Quantity >= 2)
	-- if input data have DiscountValue more than 0, all these values set 0
	update dbo.Basket
	set DiscountValue = 0
	Where ID in (select Id from inserted where Quantity < 2)	
end
CREATE FUNCTION udf_GetSKUPrice(@ID_SKU int)
		returns decimal(18, 2)
AS BEGIN
	DECLARE @val decimal(18, 2)
	select  @val = Value/ Quantity FROM dbo.Basket 
	where ID = @ID_SKU
	if(@val is null)
		set @val = 0
	return @val
END
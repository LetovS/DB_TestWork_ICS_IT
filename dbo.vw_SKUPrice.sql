create view dbo.vw_SKUPrice
as
(
	select ID
		, Name
		, Code
		, [dbo].[udf_GetSKUPrice](ID) as CostOneOfItem
	from dbo.SKU
)
CREATE VIEW vClientAssets1
AS
select
        ca.ID as ID
        ,c.ClientName as ClientName
    ,c.Description
    ,ip.CallerID
    ,a.DARAssetID
    ,a.Name as AssetName
    ,a.DARTicker
    ,coalesce(ca.ReferenceData,0) as ReferenceData
    ,coalesce(ca.Price,0) as Price
    ,a.ID as AssetID
    ,c.ID as ClientID
    , c.HourlyPrice
	, c.LatestPrice
    , c.Derivatives
	, c.NFT
from Clients1 c
inner join ClientIPs ip on c.ID = ip.ClientID
inner join ClientAssets1 ca on c.ID = ca.ClientID
inner join Asset a on a.ID = ca.AssetID;
Use austgen1_IMuDB;

-- Lists All Artist in the Database by their number of songwriting credits
Select Name , Count(WRITTEN_BY.ArtistID) AS SongsWritten
From ARTIST
LEFT Join WRITTEN_BY ON (ARTIST.ArtistID = WRITTEN_BY.ArtistID)
Group BY WRITTEN_BY.ArtistID
Order by SongsWritten Desc;

-- Returns Record Labels that released  an Album that has sold an above above average number of copies
Select Name, ALBUM.NumberSold
From RECORD_LABEL Join ALBUM Using (LabelID)
Where ALBUM.NumberSold > (Select Avg(ALBUM.NumberSold) From ALBUM)
Order by NumberSold Desc;

-- Returns Bands sorted by the Number 0f people that were in them at any point
Select Name, Count(BAND_MEMBER.PersonID) AS NumPeopleWhoHaveBeenInBand
From ARTIST 
Join BAND on (BAND.ArtistID=ARTIST.ArtistID) 
Join BAND_MEMBER on (BAND.ArtistID=BAND_MEMBER.BandID) 
Group by BAND_MEMBER.BandID
Order by NumPeopleWhoHaveBeenInBand;

-- Lists Persons in the Database and their Featured Artist credits sorted by Last name
Select LastName , Count(FEATURED_ARTIST.ArtistID) AS TimesFeatured
From PERSON
Join ARTIST on (ARTIST.ArtistID=PERSON.ArtistID)
Join FEATURED_ARTIST ON (ARTIST.ArtistID = FEATURED_ARTIST.ArtistID)
Group BY FEATURED_ARTIST.ArtistID
Order by LastName Desc;

-- Lists all cover songs and who the cover version was by.
Select ARTIST.Name, RECORDING.Title
From RECORDING JOIN ARTIST on (ARTIST.ArtistID= RECORDING.ArtistID)
Where RECORDING.CoverOf is not null;

-- Lists all songs which charted in the Bilboard Hot 100 as well as their peak position and orders by highest charting
Select RECORDING.Title, ARTIST.Name, RECORDING.TopChartPosition
From RECORDING join ARTIST on (ARTIST.ArtistID= RECORDING.ArtistID)
Where TopChartPosition is not null
Order by TopChartPosition Asc;
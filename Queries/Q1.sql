SELECT DivisionName AS DivisionName, COUNT(*) AS TotalRegVoters --counting divname as total
FROM VoterRegistry
GROUP BY DivisionName -- group by divname
ORDER BY DivisionName DESC;


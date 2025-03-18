SELECT 
    t.NAME AS TableName,
    p.rows AS RowCounts
FROM 
    sys.tables t
INNER JOIN 
    sys.partitions p ON t.object_id = p.OBJECT_ID
WHERE 
    p.index_id IN (0, 1) -- 0:Heap Table, 1:Clustered Index
ORDER BY 
    p.rows DESC;
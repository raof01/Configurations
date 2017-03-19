select ((SELECT SUM(`金额`) FROM `收支平衡表` WHERE `收支`="收入")
       - SUM(`金额`))
       as `赤字`
FROM `收支平衡表`
WHERE `收支`="支出";


source /home/eugene/Рабочий стол/unik/sql/lr1/dropAllBase.sql
SELECT REGEXP_REPLACE("stackoverflow", "(stack)(over)(flow)", '\\2 - \\1 - \\3');

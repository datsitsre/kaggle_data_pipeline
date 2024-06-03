-- Main command to run redshift platform
create table drivers 
(index int, pos DECIMAL, driver varchar, nationality varchar, car varchar, 
pts DECIMAL, year VARCHAR, code varchar);

create table laps (index int, grand_prix varchar(100), driver varchar(100), car varchar(100), time varchar, year int, code varchar(5));


create table winners (index  int, grand_prix varchar(100), date VARCHAR, winner varchar(100), car varchar(100), laps DECIMAL, time VARCHAR, name_code varchar);


copy drivers (index, pos, driver, nationality,car,pts,year,code) from 's3://pipe-data-project/drivers.csv' 
iam_role'arn:aws:iam::058264151136:role/RedShiftLoadReadOnly' 
delimiter ',' csv IGNOREHEADER 1;



copy laps (index, grand_prix, driver, car, time, year, code) from 's3://pipe-data-project/fast_laps.csv' 
iam_role'arn:aws:iam::058264151136:role/RedShiftLoadReadOnly' 
delimiter ',' csv IGNOREHEADER 1;



copy winners (index, grand_prix, date, winner, car, laps, time, name_code) from 's3://pipe-data-project/drivers.csv' 
iam_role'arn:aws:iam::058264151136:role/RedShiftLoadReadOnly' 
delimiter ',' csv IGNOREHEADER 1;
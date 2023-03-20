arduino=serial('com3','BaudRate',9600);
fopen(arduino);
delete(arduino)
clear arduino
arduino=serial('com3','BaudRate',9600);
fopen(arduino);

while 1
    fprintf(arduino, '%d',1);
end
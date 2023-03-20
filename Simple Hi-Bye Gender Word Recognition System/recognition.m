recObj = audiorecorder(44000, 24, 1);% record at Fs=44khz, 24 bits per sample
hi = 0;
bye = 0;
m = 0;
f = 0;
for i=1:1
fprintf('Please start talking for audio #%d\n',i)
recordblocking(recObj, 4); % record 4 seconds
fprintf('Audio #%d ended\n',i)
%play(recObj);
x = getaudiodata(recObj);
x = x - mean(x);
file_name = sprintf('test/word/w%d.wav',i);
audiowrite(file_name, x, recObj.SampleRate);
file_name = sprintf('test/gender/g%d.wav',i);
audiowrite(file_name, x, recObj.SampleRate);
%figure
%plot(x);
end


% arduino=serial('com3','BaudRate',9600);
% fopen(arduino);
% delete(arduino)
% clear arduino
% arduino=serial('com3','BaudRate',9600);
% fopen(arduino);


training_files_female = dir('C:\Program Files\Polyspace\R2019b\bin\DSPphase2\train\female\*.wav');
training_files_male = dir('C:\Program Files\Polyspace\R2019b\bin\DSPphase2\train\male\*.wav');
training_files_hi = dir('C:\Program Files\Polyspace\R2019b\bin\DSPphase2\train\hi\*.wav');
training_files_bye = dir('C:\Program Files\Polyspace\R2019b\bin\DSPphase2\train\bye\*.wav');

testing_files_word = dir('C:\Program Files\Polyspace\R2019b\bin\DSPphase2\test\word\*.wav');
testing_files_gender = dir('C:\Program Files\Polyspace\R2019b\bin\DSPphase2\test\gender\*.wav');

% read the 'female' training files and calculate the energy for each one.
data_female = [];
for i = 1:length(training_files_female)
file_path = strcat(training_files_female(i).folder,'\',training_files_female(i).name);
[y,fs] = audioread(file_path);
%divide the signal into 6 parts and calculate the ZCR for each part
ZCR_female1 = mean(abs(diff(sign(y(1:floor(end/6))))))./2;
ZCR_female2 = mean(abs(diff(sign(y(floor(end/6):floor (end*2/6))))))./2;
ZCR_female3 = mean(abs(diff(sign(y(floor(end*2/6):floor (end*3/6))))))./2;
ZCR_female4 = mean(abs(diff(sign(y(floor(end*3/6):floor (end*4/6))))))./2;
ZCR_female5 = mean(abs(diff(sign(y(floor(end*4/6):floor (end*5/6))))))./2;
ZCR_female6 = mean(abs(diff(sign(y(floor(end*5/5):end)))))./2;
%calculate the energy
energy = sum(y.^2);
ZCR_female = [ZCR_female1 ZCR_female2 ZCR_female3 ZCR_female4 ZCR_female5 ZCR_female5 energy];
data_female = [data_female ;ZCR_female];
end
ZCR_female=mean(data_female);
%fprintf('The ZCR of female is: \n');
%disp(ZCR_female);


% read the 'male' training files and calculate the energy for each one.
data_male = [];
for i = 1:length(training_files_male)
file_path = strcat(training_files_male(i).folder,'\',training_files_male(i).name);
[y,fs] = audioread(file_path);

%divide the signal into 6 parts and calculate the ZCR for each part
ZCR_male1 = mean(abs(diff(sign(y(1:floor(end/6))))))./2;
ZCR_male2 = mean(abs(diff(sign(y(floor(end/6):floor (end*2/6))))))./2;
ZCR_male3 = mean(abs(diff(sign(y(floor(end*2/6):floor (end*3/6))))))./2;
ZCR_male4 = mean(abs(diff(sign(y(floor(end*3/6):floor (end*4/6))))))./2;
ZCR_male5 = mean(abs(diff(sign(y(floor(end*4/6):floor (end*5/6))))))./2;
ZCR_male6 = mean(abs(diff(sign(y(floor(end*5/6):end)))))./2;
%calculate the energy
energy = sum(y.^2);

ZCR_male = [ZCR_male1 ZCR_male2 ZCR_male3 ZCR_male4 ZCR_male5 ZCR_male6 energy];

data_male = [data_male ;ZCR_male];
end
ZCR_male=mean(data_male);
%fprintf('The ZCR of male is: \n');
%disp(ZCR_male);


% read the 'hi' training files and calculate the energy for each one.
data_hi = [];
for i = 1:length(training_files_hi)
file_path = strcat(training_files_hi(i).folder,'\',training_files_hi(i).name);
[y,fs] = audioread(file_path);
%divide the signal into 6 parts and calculate the ZCR for each part
ZCR_hi1 = mean(abs(diff(sign(y(1:floor(end/6))))))./2;
ZCR_hi2 = mean(abs(diff(sign(y(floor(end/6):floor (end*2/6))))))./2;
ZCR_hi3 = mean(abs(diff(sign(y(floor(end*2/6):floor (end*3/6))))))./2;
ZCR_hi4 = mean(abs(diff(sign(y(floor(end*3/6):floor (end*4/6))))))./2;
ZCR_hi5 = mean(abs(diff(sign(y(floor(end*4/6):floor (end*5/6))))))./2;
ZCR_hi6 = mean(abs(diff(sign(y(floor(end*5/6):end)))))./2;
%calculate the energy
energy = sum(y.^2);
ZCR_hi = [ZCR_hi1 ZCR_hi2 ZCR_hi3 ZCR_hi4 ZCR_hi5 ZCR_hi6 energy];
data_hi = [data_hi ;ZCR_hi];
end
ZCR_hi=mean(data_hi);
%fprintf('The ZCR of hi is: \n');
%disp(ZCR_hi);

% read the 'bye' training files and calculate the energy for each one.
data_bye = [];
for i = 1:length(training_files_bye)
file_path = strcat(training_files_bye(i).folder,'\',training_files_bye(i).name);
[y,fs] = audioread(file_path);

%divide the signal into 6 parts and calculate the ZCR for each part
ZCR_bye1 = mean(abs(diff(sign(y(1:floor(end/6))))))./2;
ZCR_bye2 = mean(abs(diff(sign(y(floor(end/6):floor (end*2/6))))))./2;
ZCR_bye3 = mean(abs(diff(sign(y(floor(end*2/6):floor (end*3/6))))))./2;
ZCR_bye4 = mean(abs(diff(sign(y(floor(end*3/6):floor (end*4/6))))))./2;
ZCR_bye5 = mean(abs(diff(sign(y(floor(end*4/6):floor (end*5/6))))))./2;
ZCR_bye6 = mean(abs(diff(sign(y(floor(end*5/6):end)))))./2;
%calculate the energy
energy = sum(y.^2);

ZCR_bye = [ZCR_bye1 ZCR_bye2 ZCR_bye3 ZCR_bye4 ZCR_bye5 ZCR_bye6 energy];

data_bye = [data_bye ;ZCR_bye];
end
ZCR_bye=mean(data_bye);
%fprintf('The ZCR of bye is: \n');
%disp(ZCR_bye);




% read the 'word' tesing files and calculate the energy 

for i = 1:length(testing_files_word)
file_path = strcat(testing_files_word(i).folder,'\',testing_files_word(i).name);
[y,fs] = audioread(file_path);

%divide the signal into 6 parts and calculate the ZCR for each part

ZCR_word1 = mean(abs(diff(sign(y(1:floor(end/6))))))./2;
ZCR_word2 = mean(abs(diff(sign(y(floor(end/6):floor (end*2/6))))))./2;
ZCR_word3 = mean(abs(diff(sign(y(floor(end*2/6):floor (end*3/6))))))./2;
ZCR_word4 = mean(abs(diff(sign(y(floor(end*3/6):floor (end*4/6))))))./2;
ZCR_word5 = mean(abs(diff(sign(y(floor(end*4/6):floor (end*5/6))))))./2;
ZCR_word6 = mean(abs(diff(sign(y(floor(end*5/6):end)))))./2;
%calculate the energy
energy = sum(y.^2);

y_ZCR = [ZCR_word1 ZCR_word2 ZCR_word3 ZCR_word4 ZCR_word5 ZCR_word6 energy];
    %make a comparative based on cosine distance
    if(pdist([y_ZCR;ZCR_hi],'cosine') < pdist([y_ZCR;ZCR_bye],'cosine'))
        fprintf('Test file [w] #%d categorized as hi \n',i);
        hi = 1;
        
    else
        fprintf('Test file [w] #%d categorized as bye \n',i);
        bye = 1;
    end
end



% read the 'gender' tesing files and calculate the energy 

for i = 1:length(testing_files_gender)
file_path = strcat(testing_files_gender(i).folder,'\',testing_files_gender(i).name);
[y,fs] = audioread(file_path);

%divide the signal into 6 parts and calculate the ZCR for each part
ZCR_gender1 = mean(abs(diff(sign(y(1:floor(end/6))))))./2;
ZCR_gender2 = mean(abs(diff(sign(y(floor(end/6):floor (end*2/6))))))./2;
ZCR_gender3 = mean(abs(diff(sign(y(floor(end*2/6):floor (end*3/6))))))./2;
ZCR_gender4 = mean(abs(diff(sign(y(floor(end*3/6):floor (end*4/6))))))./2;
ZCR_gender5 = mean(abs(diff(sign(y(floor(end*4/6):floor (end*5/6))))))./2;
ZCR_gender6 = mean(abs(diff(sign(y(floor(end*5/6):end)))))./2;
%calculate the energy
energy = sum(y.^2);

y_ZCR = [ZCR_gender1 ZCR_gender2 ZCR_gender3 ZCR_gender4 ZCR_gender5 ZCR_gender6 energy];
    %make a comparative based on cosine distance
    if(pdist([y_ZCR;ZCR_female],'cosine') < pdist([y_ZCR;ZCR_male],'cosine'))
         fprintf('Test file [g] #%d categorized as female \n',i);
          f = 1;
    else
         fprintf('Test file [g] #%d categorized as male \n',i);
         m = 1;
    end
    
   
end


% if (hi == 1 && f == 1)
%       while 1
%        fprintf(arduino, '%d',1);
%       end
% end
% if ( hi == 1 && m == 1)
%       while 1
%           fprintf(arduino, '%d', 2);
%       end
% end
%  if (bye == 1 && f ==1)
%         while 1
%         fprintf(arduino, '%d', 3);
%         end
%  end
%  if (bye == 1 && m == 1)
%         while 1
%         fprintf(arduino, '%d', 4);
%         end
% end








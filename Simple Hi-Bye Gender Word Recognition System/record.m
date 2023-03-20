recObj = audiorecorder(44000, 24, 1);% record at Fs=44khz, 24 bits per sample
for i=1:1
fprintf('Please start talking for audio #%d\n',i)
recordblocking(recObj, 3); % record 4 seconds
fprintf('Audio #%d ended\n',i)
%play(recObj);
x = getaudiodata(recObj);
x = x - mean(x);
file_name = sprintf('train/hi/hi%d.wav',i);
audiowrite(file_name, x, recObj.SampleRate);
%figure
%plot(x);
end
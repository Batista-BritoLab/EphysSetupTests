% get the latest created file in the folder
d = dir('C:\tmp\');
[~,idx] = max([d.datenum]);
FileName = d(idx).name;

vidobj=VideoReader(strcat('C:\tmp\',FileName));
frames=read(vidobj,'default');

vidobj.NumberOfFrames

% frame1=frames(:,:,1,53);
% frame2=frames(:,:,1,2);
% frame3=frames(:,:,1,3);
% 
% frame1(1:10,1:20)
% frame2(1:10,1:20)
% frame3(1:10,1:20)
second_count = zeros(vidobj.NumberOfFrames,1);
cycle_count = zeros(vidobj.NumberOfFrames,1);
cycle_offset = zeros(vidobj.NumberOfFrames,1);

for frameNo=1:vidobj.NumberOfFrames

    timeStampBin = dec2bin(frames(1,1:4,1,frameNo),8);
% second = timeStampBin(1,1:7);
% cycle1 = timeStampBin(1,8);
% cycle2 = timeStampBin(2,1:8);
% cycle3 = timeStampBin(3,1:4);
% cycle_offset1 = timeStampBin(3,5:8);
% cycle_offset2 = timeStampBin(4,1:8);
% cycle = strcat(cycle1,cycle2,cycle3);
% cycle_offset = strcat(cycle_offset1,cycle_offset2);
    second_count(frameNo) = bin2dec(timeStampBin(1,1:7));
    cycle_count(frameNo) = bin2dec(strcat(timeStampBin(1,8),timeStampBin(2,1:8),timeStampBin(3,1:4)));
    cycle_offset(frameNo) = bin2dec(strcat(timeStampBin(3,5:8),timeStampBin(4,1:8)));
end

frameCountDiff = diff(cycle_count);
frameCountDiff(frameCountDiff < 0) = frameCountDiff(frameCountDiff < 0) + 8000;

frameSecDiff = frameCountDiff/8;
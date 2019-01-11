% get the latest created file in the folder
clear all

d = dir('C:\tmp\');
d = d([d.bytes] == 1241632);
% [~,idx] = sort([d.datenum]);
% 
% d = d(idx');

% size(d(1).name,2)
% FileName = reshape([d(idx').name],[size(d(1).name,2),size(d,1)]);
% 
headerMatrix = zeros(size(d,1),8);

for fileNo=1:size(d,1)
	FileName = d(fileNo).name;

    fin=fopen(strcat('C:\tmp\',FileName),'r');
    I=fread(fin,8, 'uint8=>uint8');
    fclose(fin);
    
    headerMatrix(fileNo,:) = I;
    
    if mod(fileNo,1000) == 0
        fileNo
    end
end

frameNumber = (headerMatrix(:,5)*2^24) + (headerMatrix(:,6)*2^16) + (headerMatrix(:,7)*2^8) + (headerMatrix(:,8));

[~,idx] = sort(frameNumber);
headerMatrix = headerMatrix(idx',:);

frameNumber = (headerMatrix(:,5)*2^24) + (headerMatrix(:,6)*2^16) + (headerMatrix(:,7)*2^8) + (headerMatrix(:,8));
frameNumber(end) - frameNumber(1);

frameNumberSteps = diff(frameNumber);

frameNumberSteps(frameNumberSteps ~= 1) - 1

find(frameNumberSteps ~= 1)

second_count = zeros(size(d,1),1);
cycle_count = zeros(size(d,1),1);
cycle_offset = zeros(size(d,1),1);

for frameNo=1:size(d,1)

    timeStampBin = dec2bin(headerMatrix(frameNo,1:4),8);
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

% frameMilliSecond = (second_count*1e3 + cycle_count/8)';
frameCountDiff = diff(cycle_count);
frameCountDiff(frameCountDiff < 0) = frameCountDiff(frameCountDiff < 0) + 8000;

frameMilliSecond = frameCountDiff/8;

find(frameMilliSecond >40) - find(frameNumberSteps ~= 1)


1 + size(d,1) + sum((frameNumberSteps(frameNumberSteps ~= 1) - 1)) 

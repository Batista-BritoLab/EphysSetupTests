clear all

signalsRecordingSession = daq.createSession('ni');
testDigitalOutputSession = daq.createSession('ni');

addDigitalChannel(testDigitalOutputSession,'Dev2','port0/line7','OutputOnly');
addAnalogInputChannel(signalsRecordingSession,'Dev2',0:1,'Voltage');

%Configuring the session of recording analog inputs
signalsRecordingSession.Rate = 2.5e3;
for chNo=1:size(signalsRecordingSession.Channels,2)
    signalsRecordingSession.Channels(1,chNo).TerminalConfig = 'SingleEnded';
end
signalsRecordingSession.IsNotifyWhenDataAvailableExceedsAuto = 0;
signalsRecordingSession.IsContinuous = true;
inputSavingDur = 10;
signalsRecordingSession.NotifyWhenDataAvailableExceeds = signalsRecordingSession.Rate * inputSavingDur; %saving every 10 seconds

fid1 = fopen('log.bin','w');
lh = signalsRecordingSession.addlistener('DataAvailable',@(src, event)logData(src, event, fid1));



%start the recording of signals
signalsRecordingSession.startBackground();


% testDigitalOutputSession.outputSingleScan(0);
% testDigitalOutputSession.outputSingleScan(1);
% pause(5);
% testDigitalOutputSession.outputSingleScan(0);


pause(inputSavingDur+1)
signalsRecordingSession.stop()
delete(lh);
fclose(fid1);

fid2 = fopen('log.bin','r');
% testData = fread(fid2,'double');
[data,count] = fread(fid2,[3,inf],'double');
fclose(fid2);

t = data(1,:);
ch = data(2:3,:);
plot(t, ch);
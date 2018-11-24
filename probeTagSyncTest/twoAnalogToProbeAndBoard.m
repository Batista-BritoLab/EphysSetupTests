clear all

probeTagSyncTestSession = daq.createSession('ni');
probeTagSyncTestSession.addAnalogOutputChannel('Dev1',0:1,'Voltage');
probeTagSyncTestSession.addDigitalChannel('Dev1','port0/line0','OutputOnly');

recStartStopSession = daq.createSession('ni');
recStartStopSession.addDigitalChannel('Dev1','port1/line0:7','OutputOnly');
recStartTrigger = [0,1,0,0,0,0,0,0];
recStopTrigger = [0,0,0,0,0,0,0,0];

Fs = 100e3; % DAQ sampling frequency (Hz)
probeTagSyncTestSession.Rate = Fs;
probeTagSyncTestSession.outputSingleScan([0 0 0]);
% probeTagSyncTestSession.outputSingleScan([1 1 1]);

stimDur = 2e-1; % in sec
stim = [[ones(stimDur*Fs,1)]',0];
testNo = 10;

recStartStopSession.outputSingleScan(recStartTrigger);

for loop=1:testNo
    
    pause(0.2);

    probeTagSyncTestSession.queueOutputData([0.2*stim',0.2*stim',stim']);
    probeTagSyncTestSession.prepare;

    probeTagSyncTestSession.startBackground();
    
    probeTagSyncTestSession.wait();

end

recStartStopSession.outputSingleScan(recStopTrigger);

probeTagSyncTestSession.release();
probeTagSyncTestSession.removeChannel(1:numel(probeTagSyncTestSession.Channels));

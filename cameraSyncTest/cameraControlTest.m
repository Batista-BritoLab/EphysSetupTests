clear all

CameraEphysStopStart = daq.createSession('ni');
recStartStopSession = daq.createSession('ni');

recStartStopSession.addDigitalChannel('Dev2','port0/line2','OutputOnly');
recStartTrigger = [1];
recStopTrigger = [0];
recStartStopSession.outputSingleScan(recStopTrigger);

Fs = 5e3; % DAQ sampling frequency (Hz)
CameraEphysStopStart.Rate = Fs;
addAnalogOutputChannel(CameraEphysStopStart,'Dev2',0,'Voltage');

triggeringFreq = 25;
recordingDur = 4; % in Sec
w = 10e-3;

t = 0 : 1/Fs : recordingDur;         % 1 kHz sample freq for 1 s
d = w/2 : 1/triggeringFreq : recordingDur;           % 3 Hz repetition frequency
triggeringPulses = 2*pulstran(t,d,'rectpuls',w);

close all
plot(t,triggeringPulses)
xlabel 'Time (s)', ylabel Waveform
ylim([0,3])

CameraEphysStopStart.queueOutputData([triggeringPulses 0]');
CameraEphysStopStart.prepare;

recStartStopSession.outputSingleScan(recStartTrigger);

CameraEphysStopStart.startForeground();

recStartStopSession.outputSingleScan(recStopTrigger);


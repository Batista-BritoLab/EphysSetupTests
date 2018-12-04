clear all

%rough estimation for the time of a 360 deg rotation: 0.5 s

niDevName = 'Dev2';
niPortLine = 'port0/line0';

rewardStepMotorCtl = daq.createSession('ni');
rewardStepMotorCtl.addDigitalChannel(niDevName,niPortLine,'OutputOnly');

[step,exactvalue] = deliverReward(2,5,rewardStepMotorCtl);

rewardStepMotorCtl.release();
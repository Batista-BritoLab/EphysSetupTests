Codes for generating visual stimuli with accurate timing using PTB and checking the timing using the photodiode signal and digital tags sent through NI-card

Stimulus timing and duration designed by PTB and Matlab (code included in the mFile). Recorded test with 20 stimulus each 5 frame duration in 180Hz refresh rate (rhd file includes the digital tags recorded with Intan and the analog signal from the photodiode). The results of the tests of the digital tags and photodiode signal were done by python (code and results included in the ipynb file).

Details of the connections: photodiode SM1PD1A, screens: 1&2 - Asus ROG PG248Q (two screens mirroed in windows and used for stimulus presentation, one connected with a short cable and the other one with a 15 ft cable) 3 - Samsung S24E650 (extended screen for matlab report, connected through HDMI), presentation computer: HP OMEN with Nvidia 1080Ti

Cables that Worked with 180Hz: 1- 5.5-feet E326508 Amphenol (DP to DP, and with mini dp to DP adaptorE164571 for AMD) 2- 5-feet E246588 Horton (DP to DP, and with mini dp to DP adaptorE164571 for AMD) 3- 6-feet 05VX0-AA10-813 (mini dp tp dp) 4- 15 feet E342987 (StarTech?)

Other cables: Up to 144 Hz but not 180 Hz; 15-feet Amazon basics (and it doesn’t have the lock!)

Conclusion: 
1- cable quality is very important: get good 15 feet cables and do exhausive tests
2- always keep the presenting screen as the primary one 
3- windows doesn't allow more than two screen mirrored so in case of two screens used for the stimulation, a camera should be used for the experiment control
4- onboard and AMD graphic cards on Dell 3420 could not reliably drive two mirrored 180 Hz, however they were working fine with one 180 Hz screen as the primary monitor

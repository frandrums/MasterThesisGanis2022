**MASTER THESIS CONTENT**
The repository is part of the Master Thesis intitled "" 
as final realization of Francesco Ganis' Master Course at the Sound and Music Computing programme at Aalborg University of Copenhagen.

Folder *SoftToyPrototype* contains the 3D model of the enclosure for the haptic actuator. 

Folder *TabletPrototype* contains the 3D model of the enclosure for the circuitry and the haptic actuator. 

Folder *TickleTuner* contains the following items:
- Folder *3D_Model*: skeleton and haptuator box of the Tickle Tuner (OpenSCAD) and Blender project with the final model. 
- Folder *MCI_Test*: all the data retrieved during the Melodic Contour Identification test as well as analysis scripts on MATLAB. 
	- Folder *Answers*: contains the .txt and demographics (.xlxs file) outputs of each participant and the analysis script of the data
	- *MelodyContourTest.pd*: Pure Data patch, engine of the test 
	- *MelodyContourTest.mmp*: MobMuPlat GUI
	- *AllSounds.txt*: list of the names of all the 144 audio files part of the test
	- *WriteRightChannelAM.m*: script for overwriting the right channel with the AM mapping
	- *AMRightChannel.m*: function for writing the AM mapping used in the script above listed
	- *MergeAllTXTFiles.m*: reads and merges the txt files contained in the folder *Lists*
	- *WriteSineWavesBothChannels.m*: script for generating sinewaves following the predefined melodic contours
	- *WriteSineNotes.m*: function for writing each note used in the above listed script
	- *Instruments_Analysis*: script for spectrograms visualization
- Folder *Preliminary_Test*: all the data retrieved during the Preliminary test as well as analysis scripts on MATLAB.
	- Folder *Answers*: contains the .txt outputs of each participant and the analysis script of the data
- Folder *Recordings*: audio files with the recordings of used for the frequency response measurament.
- *Analysis.m*: script for the analysis of the frequency response.
- *Write_FreqLogSweep.m*: script for the generation of the logarithmic frequency sweep used for the frequency response measurament. 
- *Accelerometer_Measures.m*: script for reading and savings the accelerometer's output. 
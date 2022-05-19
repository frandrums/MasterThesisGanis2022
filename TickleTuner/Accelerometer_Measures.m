%% 
close, clear all
clc

%% Audio settings

deviceReader = audioDeviceReader;   

setup(deviceReader)

release(deviceReader)
deviceReader.Driver = 'ASIO';
deviceReader.Device = "Yamaha Steinberg USB ASIO";
deviceReader.NumChannels = 2;

% deviceReader.Driver = 'ASIO';
% deviceReader.Device = "Focusrite USB ASIO";
% deviceReader.NumChannels = 2;
% deviceReader.SamplesPerFrame = 512;


fs = deviceReader.SampleRate;

%% Recording environment
numRecord = 1;
nameLocation = 'Screen_center';

fileWriter = dsp.AudioFileWriter(sprintf('Rec_%s_%i.wav', nameLocation, ...
    numRecord),'FileFormat','WAV');



[swipeOriginal, fsSwipe] = audioread("Sweep_1_10000.wav");

duration = size(swipeOriginal, 1) / fsSwipe;

disp("I'm recording.")

tic
while toc < duration + 3
    acquiredAudio = deviceReader();
    fileWriter(acquiredAudio);
end

disp('Recording complete.')

release(deviceReader)
release(fileWriter)

%% Plot

selectedCh = audioread(sprintf('Rec_%s_%i.wav', nameLocation, numRecord));
selectedCh = selectedCh(:,2);
plot(selectedCh);

%% Spectrum
figure

[S, F, T] = spectrogram (selectedCh(:, 1) ,512, 64,512, fs, 'yaxis');

%Plot the spectrogram of the original file
imagesc(T,F,20*log10(abs(S)))
set(gca,'YDir','normal')
xlabel('time [s]')
ylabel('frequency [Hz]')

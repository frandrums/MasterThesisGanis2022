clear, clc, close all

% From - A. Farina, "Simultaneous measurement of impulse response and 
% distortion with a swept-sine technique," p. 24, 2000.

%% Measurement preparation
% preparation of the time vector
fs = 44100;
dur = 15; % Duration of the swipe
nSamples = round(dur*fs);
t = (0:nSamples-1)/fs; % Time vector

% Frequency boundaries
fStart = 1;
wStart = 2 * pi * fStart;
fEnd = 10000;
wEnd = 2 * pi * fEnd;


sweep = zeros(nSamples, 2);

K = (dur * wStart) / log(wEnd/wStart);
L = (dur) / log(wEnd/wStart);

% Sync source to align original audio file with recording
gaussNSamples = 100;
amplitude = 0.9;
gaussImpulse = amplitude * gausswin(gaussNSamples);
gaussImpulse = cat(1, zeros(fs/2, 2), [gaussImpulse, gaussImpulse]);

nSweeps = 10;

% Write the audiofile 
for i = 1 : nSamples
    sweep(i, :) = amplitude * sin(K * (exp(t(i)/L) - 1));
end

output = [];

% Write nSweep sine sweep with a second of gap in between
for cnt = 1 : nSweeps 
    output = cat(1, output, sweep);
    % 1 second gap
    output = cat(1, output, zeros(fs, 2));
end

% Add the sync source and another second of gap
gaussImpulse = cat(1, gaussImpulse, zeros(fs, 2));
% Combine all together
output = cat(1, gaussImpulse, output);

% Write the audiofile
audiowrite (sprintf('Sweep_%d_%d.wav', fStart, fEnd), output, fs);



%% Plot
figure
plot(output)

%% Spectrogram
figure

[S, F, T] = spectrogram (output(:, 1) ,512, 64,512, fs, 'yaxis');

%Plot the spectrogram of the original file
imagesc(T,F,20*log10(abs(S)))
set(gca,'YDir','normal')
xlabel('time [s]')
ylabel('frequency [Hz]')
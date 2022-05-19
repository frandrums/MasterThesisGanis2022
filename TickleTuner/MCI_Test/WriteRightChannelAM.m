clear, close  all

%% Prepare the notes
c3 = 130.813 * 1; % [Hz]
bpm = 120;
durNote = 60 / bpm; % Duration of each note [s]
amplitude = 1;

% Distance between notes in semitones for each contour
noteContours2 = [0, 2, 4, 6, 8; %Ascending
    8, 6, 4, 2, 0;  %Descending
    0, 2, 4, 2, 0;  %Ascending/Descending
    8, 6, 4, 6, 8;  %Descending/Ascending
    0, 0, 0, 2, 4;  %Still/Ascending
    4, 2, 0, 0, 0]; %Descending/Still



noteContours1 = [0, 1, 2, 3, 4; %Ascending
    8, 7, 6, 5, 4;  %Descending
    0, 1, 2, 1, 0;  %Ascending/Descending
    8, 7, 6, 7, 8;  %Descending/Ascending
    0, 0, 0, 1, 2;  %Still/Ascending
    2, 1, 0, 0, 0]; %Descending/Still

fileNames = ["asc", "desc", "ascDesc", "descAsc", "stillAsc", "descStll"];

% Frequency arrays for each contour
frequencyContours2 = c3 .* 2.^(noteContours2 ./ 12);
frequencyContours1 = c3 .* 2.^(noteContours1 ./ 12);


% Min and max freq for AM to detect
fAMmin = c3 * 2^(0/12) - 5; % -1 to avoid sin(0) in AM
fAMmax = c3 * 2^(8/12);
fAMmult = 20; % Range multiplier e.g. fAMmult = 20 => fAm > 0 & fAm < 20


%% Prepre the audio chunks
% Change name for every instrument 
instrument = "Piano";

input1 = strcat(pwd, "\Original_AudioFiles\CI_Emulations\CI",...
    instrument, "_1.wav");
input2 = strcat(pwd, "\Original_AudioFiles\CI_Emulations\CI",...
    instrument, "_2.wav");

allAudio1 = audioread(input1);
[allAudio2, fs] = audioread(input2);

durationContour = durNote * fs * 5; % Without 1 bar silence!
chunk = 1;

output1 = [];

% For every contour
for idx = 1 : size(noteContours1, 1)
    output1 = cat(1, output1, AMRightChannel(allAudio1(chunk : chunk + ...
        durationContour), fs, frequencyContours1(idx, :), durNote, amplitude, ...
        fAMmin, fAMmax, fAMmult));

    % Move to the next contour skipping one bar of silence.
    chunk = chunk + durationContour + durNote * fs;
end

output2 = [];
chunk = 1;

% For every contour
for idx = 1 : size(noteContours2, 1)
    output2 = cat(1, output2, AMRightChannel(allAudio2(chunk : chunk + ...
        durationContour), fs, frequencyContours2(idx, :), durNote, amplitude, ...
        fAMmin, fAMmax, fAMmult));

    % Move to the next contour skipping one bar of silence.
    chunk = chunk + durationContour + durNote * fs;
end

%% Write single audio files
chunk = 1;
for idx = 1 : size(noteContours1, 1)
    audiowrite(strcat("1_", fileNames(idx), "_", instrument, "_CIAM.wav"), ...
        output1(chunk : chunk + durationContour, :), fs);

    audiowrite(strcat("2_", fileNames(idx), "_", instrument, "_CIAM.wav"), ...
        output2(chunk : chunk + durationContour, :), fs);
%     audiowrite(strcat("1_", fileNames(idx), "_", instrument, "_CI_NoH.wav"), ...
%         output1(chunk : chunk + durationContour, :), fs);
% 
%     audiowrite(strcat("2_", fileNames(idx), "_", instrument, "_CI_NoH.wav"), ...
%         output2(chunk : chunk + durationContour, :), fs);
    chunk = chunk + durationContour;
end

%% Generate textfiles
formatSpec1 = '1_%s_%s_CIAM.wav;\r\n';
formatSpec2 = '2_%s_%s_CIAM.wav;\r\n';
% formatSpec1 = '1_%s_%s_CI_NoH.wav;\r\n';
% formatSpec2 = '2_%s_%s_CI_NoH.wav;\r\n';

fileID = fopen(strcat("", instrument, "_AM_list.txt"), "w");
% fileID = fopen(strcat("", instrument, "_NoH_list.txt"), "w");
tmp = [fileNames', repmat(instrument, size(fileNames', 1), 1)]';
fprintf(fileID, formatSpec1, tmp);
% fclose(fileID);

% fileID = fopen(strcat("2_", instrument, "_list.txt"), "w");
fprintf(fileID, formatSpec2, tmp);
fclose(fileID);

%% Plot
% spectrogram(output1(:, 2), 'yaxis');

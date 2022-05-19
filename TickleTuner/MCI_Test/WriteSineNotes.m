function [output, fs] = WriteSineNotes(audio, fs, freqSet, durNote, ...
    amplitude)

nNote = 1;
nSample = 1;
phaseFC = 0;

output = audio;

% For every note in the selected contour
while (nNote <= length(freqSet))

    % Carrier frequency and phaseStep
    fc = freqSet(nNote);
    phaseStepFC = 2 * pi * fc / fs;


    for idx = 1 : durNote * fs
        % Write only the right channel (haptics)
        output(idx + nSample, :) = amplitude * sin(phaseFC);
        phaseFC = phaseFC + phaseStepFC; % Update carrier phase
    end

    nNote = nNote + 1; % Point to the next note
    nSample = nSample + durNote * fs; % Point to the next sample chunk

end

end
function [output, fs] = AMRightChannel(audio, fs, freqSet, durNote, ...
    amplitude, fAMmin, fAMmax, fAMmul)

nNote = 1;
nSample = 1;
phaseFC = 0;
phaseFM = 0;

output = audio;

% For every note in the selected contour
while (nNote <= length(freqSet))

    % Carrier frequency and phaseStep
    fc = freqSet(nNote);
    phaseStepFC = 2 * pi * fc / fs;

    % Modulator frequency and phaseStep
    fm = (freqSet(nNote) - fAMmin) / (fAMmax - fAMmin) * fAMmul;
    phaseStepFM = 2 * pi * fm / fs;

    for idx = 1 : durNote * fs
        % Write only the right channel (haptics)
        output(idx + nSample, 2) = amplitude * sin(phaseFC) * sin(phaseFM);
        phaseFC = phaseFC + phaseStepFC; % Update carrier phase
        phaseFM = phaseFM + phaseStepFM; % Update modulator phase
    end

    nNote = nNote + 1; % Point to the next note
    nSample = nSample + durNote * fs; % Point to the next sample chunk

end

end
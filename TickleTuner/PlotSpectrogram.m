function [outputArg1,outputArg2] = PlotSpectrogram(dataset, fs,window, ...
    nOverlap, NFFT, fLimit, titleToDisplay)
%PLOTSPECTROGRAM Plot the spectrogram of an audiofile

    if nargin < 3
        window = 512;
    end

    if nargin < 4
        nOverlap = 64;
    end

    if nargin < 5
        NFFT = 512;
    end

    if nargin < 6
        fLimit = fs / 2;
    end

    if nargin < 7
        titleToDisplay = 'Spectrogram';
    end

%     figure

    [S, F, T] = spectrogram (dataset ,window, nOverlap, ...
        NFFT, fs, 'yaxis');

    f = [0 : fLimit]';

    imagesc(T, f, 20*log10(abs(S)))
    set(gca,'YDir','normal')
    xlabel('Time [s]')
    ylabel('Frequency [Hz]')
    title(titleToDisplay)

end


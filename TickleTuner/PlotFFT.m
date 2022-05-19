function P1 = PlotFFT(dataset, fs, fLimit, ...
    titleToDisplay, db, viewGrid, semilog, smooth, winSmooth)
%PLOTFFT Plot the FFT of the input signal

if nargin < 3
    fLimit = fs / 2;
end

if nargin < 4
    titleToDisplay = 'Single-Sided Amplitude Spectrum';
end

if nargin < 5
    db = false;
end

unmeas = '';

if nargin < 8
    smooth = false;
end

if nargin < 9
    winSmooth = 128;
end


L = size(dataset, 1);
Y = fft(dataset);

% Smoothing
if smooth == true
    Y = smoothdata(Y, 'sgolay', winSmooth);
end


P2 = abs(Y/L);
LLim = round((fLimit * L) / fs);
P1 = P2(1 : ((LLim) + 1));
P1(2 : end-1) = 2 * P1(2 : end-1);

% X axis with lim
f = fs * (0 : (LLim)) / L;


if db == true
    P1 = 20 * log10(P1);
    unmeas = '[dB]';
end

if nargin < 6
    viewGrid = false;
end

% Normal plot
if nargin < 7 || semilog == false

    plot(f, P1)
    title(titleToDisplay)
    xlabel('f [Hz]')
    ylabel(sprintf('|P1(f)| %s', unmeas))

    if viewGrid
        grid on
    else
        grid off
    end
else

    % Logarithmic plot
    semilogx(f, P1)
    title(titleToDisplay)
    xlabel('f [Hz]')
    ylabel(sprintf('|P1(f)| %s', unmeas))

    if viewGrid
        grid on
    else
        grid off
    end
end

end
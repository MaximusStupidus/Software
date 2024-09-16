clear;



resultsDir = 'Results/';
defaultPyrType = 'halfOctave'; % Half octave pyramid is default as discussed in paper
scaleAndClipLargeVideos = true; % With this enabled, approximately 4GB of memory is used

% Uncomment to use octave bandwidth pyramid: speeds up processing,
% but will produce slightly different results
defaultPyrType = 'octave'; 

% Uncomment to process full video sequences (uses about 16GB of memory)
%scaleAndClipLargeVideos = false;
inFile = fullfile('/Users/ojasjain/Desktop/Deployment/uploads/2505_240FPS Cropped.mp4');
samplingRate = 30; % Hz
loCutoff = 5;    % Hz
hiCutoff = 14;    % Hz
alpha = 15;    
sigma = 3;         % Pixels
pyrType = 'octave';
if (scaleAndClipLargeVideos)
    phaseAmplify(inFile, alpha, loCutoff, hiCutoff, samplingRate, resultsDir,'sigma', sigma,'pyrType', pyrType,'scaleVideo', 0.5);
else
    phaseAmplify(inFile, alpha, loCutoff, hiCutoff, samplingRate, resultsDir,'sigma', sigma,'pyrType', pyrType,'scaleVideo', 1);
end
% The sequence is very large. To save on CPU time, we set
% pyramid type to 'octave'. If you have the resources or time, feel free to change it
% to 'halfOctave'

------------

function reproduceResultsSiggraph13(videoFilePath, samplingRate, loCutoff, hiCutoff, alpha, sigma, pyrType)
    % This function processes the input video file specified by videoFilePath 
    addpath(genpath('/Users/ojasjain/Desktop/Deployment/Video_Magnification/Release/PhaseBased'));
    addpath(genpath('/Users/ojasjain/Desktop/Deployment/Video_Magnification/Release/pyrToolsExt'));
    addpath(genpath('/Users/ojasjain/Desktop/Deployment/Video_Magnification/Release/Filters'));
    addpath(genpath('/Users/ojasjain/Desktop/Deployment/Video_Magnification/Release/Util'));

    % Set directories for data and results
    dataDir = './data';
    resultsDir = '/Users/ojasjain/Desktop/Deployment/uploads/Processed Videos';
    
    % Default pyramid type and memory settings
    defaultPyrType = 'halfOctave'; % Half octave pyramid is default as discussed in paper
    scaleAndClipLargeVideos = true; % With this enabled, approximately 4GB of memory is used

    % Use the passed video file path instead of a hardcoded path
    inFile = videoFilePath;

    % Debugging: Display the video file path and parameters
    disp(['Video file path: ', videoFilePath]);
    disp(['Sampling Rate: ', num2str(samplingRate)]);
    disp(['Low Cutoff Frequency: ', num2str(loCutoff)]);
    disp(['High Cutoff Frequency: ', num2str(hiCutoff)]);
    disp(['Alpha: ', num2str(alpha)]);
    disp(['Sigma: ', num2str(sigma)]);
    disp(['Pyramid Type: ', pyrType]);
    
    % Process the video with phase amplification
    if (scaleAndClipLargeVideos)
        phaseAmplify(inFile, alpha, loCutoff, hiCutoff, samplingRate, resultsDir, 'sigma', sigma, 'pyrType', pyrType, 'scaleVideo', 0.5);
    else
        phaseAmplify(inFile, alpha, loCutoff, hiCutoff, samplingRate, resultsDir, 'sigma', sigma, 'pyrType', pyrType, 'scaleVideo', 1);
    end
end
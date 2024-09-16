% [PYR, PIND] = buildSCFpyrGenPar(IM, croppedFilters, FILTIDX, ...)
%


function [pyr,pind] = buildSCFpyrGen(im, croppedFilters, filtIDX, varargin)

%if(not(isa(filtersD,'distributed')))
%    error('Second argument must be a distributed array of spatial filters\n');
%end
    

nFilts = max(size(croppedFilters));

% Parse optional arguments
p = inputParser;

defaultInputIsFreqDomain = false;
addOptional(p, 'inputFreqDomain', defaultInputIsFreqDomain, @islogical);

parse(p,  varargin{:});
isFreqDomain = p.Results.inputFreqDomain;


% Return pyramid in the usual format of a stack of column vectors
if (isFreqDomain)
    imdft = im;
else
    imdft = fftshift(fft2(im)); %DFT of image
end



%pyr = (cell(1,nFilts));
%pind = (cell(1,nFilts));



pyr = [];
pind = zeros(nFilts,2);
for k = 1:nFilts      
    tempDFT = croppedFilters{k}.*imdft(filtIDX{k,1}, filtIDX{k,2}); % Transform domain                           
    curResult = ifft2(ifftshift(tempDFT));
    %pyr{k} = curResult(:);
    %pind{k} = size(curResult);
    pind(k,:) = size(curResult);
    pyr = [pyr; curResult(:)];
end
end

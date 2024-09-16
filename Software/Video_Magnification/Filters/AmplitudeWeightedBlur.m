function out = AmplitudeWeightedBlur( in, weight, sigma )
    if (sigma~=0)
        kernel = fspecial('gaussian', ceil(4*sigma), sigma);
        sz = size(kernel);
        weight = weight+eps;
        out = imfilter(in.*weight, kernel,'circular');
        weightMat = imfilter(weight,kernel,'circular');
        out = out./weightMat;
    else
        out = in;
    end
end


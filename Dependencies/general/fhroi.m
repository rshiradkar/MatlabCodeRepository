function bwMask = fhroi(axHandle)
% FHROI:  Interactively specify 2D freehand ROI
%
% Overlays an imfreehand ROI on an image.
% Gives the ability to tweak the ROI by adding and
%   subtracting regions as needed, while updating
%   the ROI boundaries as an overlay on the image.
% Returns a logical matrix of the same size as the
%   overlain image.
%
% Requires alphamask:
%   http://www.mathworks.com/matlabcentral/fileexchange/34936
%
% Usage:
%   bwMask = fhroi([axHandle])
%     axHandle: handle to axes on which to operate (optional)
%       bwMask: ROI mask as logical matrix
%
% Example:
%   figure;
%   I = rand(20) + eye(20);
%   imshow(I, [], 'Colormap', hot, 'initialMagnification', 1000);
%   bwMask = fhroi;
%
% See also IMFREEHAND, CREATEMASK

% v0.6 (Feb 2012) by Andrew Davis -- addavis@gmail.com


% Check input and set up variables
if ~exist('axHandle', 'var'), axHandle = gca; end;
imHandle = imhandles(axHandle);
imHandle = imHandle(1);             % First image on the axes
hOVM = [];                          % no overlay mask yet

% User instructions and initial area
disp('1. Use zoom and pan tools if desired');
disp('2. Make sure no tools are selected')
disp('3. Left click and drag to add closed loop');

fhObj = imfreehand(axHandle);          % choose initial area
%position = wait(fhObj);               % allow repositioning

try
   bwMask = createMask(fhObj, imHandle);  % logical matrix of image size
catch ME
   error('bwMask ROI was not created properly');
end
delete(fhObj);                         % clean up


% Await user input to determine if the ROI needs tweaking
roiLoop = 1;
while(roiLoop),
   delete(hOVM);                       % delete old overlay mask
   hOVM = alphamask(bwMask);           % overlay image with mask
   nextAction = menu('Choose an option','Add to ROI','Subtract from ROI','Delete ROI','Done');
   if nextAction == 1,                 % draw with imfreehand and add to roi
      fhAdd = imfreehand;
      bwAdd = createMask(fhAdd, imHandle);
      bwMask = bwMask | bwAdd;         % logical 'bwMask or bwAdd'
      delete(fhAdd);
   elseif nextAction == 2,             % draw with imfreehand and subtract from roi
      fhSub = imfreehand;
      bwSub = createMask(fhSub, imHandle);
      bwMask = bwMask & ~bwSub;        % logical 'bwMask and not bwSub'
      delete(fhSub);
   elseif nextAction == 3,             % delete roi
      bwMask = bwMask & 0;             % logical 'bwMask and 0'
   elseif nextAction == 4,             % user is happy with ROI
      roiLoop = 0;
   end;
end;


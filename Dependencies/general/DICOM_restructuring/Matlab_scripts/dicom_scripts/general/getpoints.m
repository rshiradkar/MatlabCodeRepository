function [x,y,but] = getpoints(N)
% GETPOINTS Interactively get coordinates on an axis.
% [XPTS,YPTS] = GETPOINTS(N)
%
%   Gets N points with left mouse click.  Right click for last point OR hit
%   enter when done.
%
% JC

% If number of points not specified, keep going until right click or enter.
if nargin~=1,
    N=Inf;
end

% Initialize
x=[]; y=[];

% Start grabbing points
done=0;
count=1;
while ~done,
    % Get one
    [xi,yi,but]=ginput(1);
    
    if ~isempty(xi), % ...if we got one
        % Add it to the list
        x(count)=xi; %#ok<AGROW>
        y(count)=yi; %#ok<AGROW>
        
        % Plot it
        hold on;
        % plot(x(count),y(count),'r+')
        scatter(x(count),y(count),25,'filled');
        
        % Number it on the plot
        text(x(count),y(count),num2str(count));
    else but=3;
    end
    
    % Are we done or was the right button clicked?
    if but==3 || count>=N, done=1; end
    count=count+1;
end

% Output Columns
x=x';
y=y';

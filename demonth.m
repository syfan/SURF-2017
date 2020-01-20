% Remove seasonal cycle
% y has the time dimension in the last dimension
% t must be decimal year
function [y_dmn, y_mn12, y_mn]=demonth(t,y,nan,W)

if nargin<3
  nan=NaN;
end

disp('  %% Deseasonalizing ... ')

% Determine whether it is single-precision or double-precision %
classname=whos('y');
classname=classname.class;

% weighting; if not supplied, put them as ones %
if nargin<4, W=ones(size(y),classname); end
if size(y) ~= size(W), error('Dimensions of y and W are not the same'); end

% Check whether t is decimal year %
if abs(t)>3000, error('t must be in decimal year'); end
% Check whether the first dimension of y is time %
if length(find(size(t)>1))>1, error('t must be a vector'); end
ndim = length(size(y));
if size(y,ndim)~=length(t), error('last dimension of y must be time'); end
nt = length(t);

% Size of y %
sz = size(y);
m=prod(sz(1:end-1));
% Make it 2D %
if length(sz)>2
  y  = reshape(y,m,nt);
  W = reshape(W,m,nt);
end

% Get the monthly averages %
y_mn12 = mnave(t,y,nan,W);
t_mn14 = [-0.5:1:12.5]/12;
y_mn = zeros(size(y),classname) + nan;
t=t-floor(t);
nx = size(y,1);

for j=1:nx
  y_mn14 = [y_mn12(j,end) y_mn12(j,:) y_mn12(j,1)];
  ind = find(y_mn14 ~= nan & ~isnan(y_mn14) );
  if length(ind)==14  % At this moment, only the full monthly mean will be used
    y_mn(j,:)=interp1(t_mn14(ind),y_mn14(ind),t,'pchip');
  else
    %error('some months are missing')
    y_mn(j,:)=nan;
  end
end

ind = uint32(find((y~=nan & ~isnan(y)) & (y_mn~=nan & ~isnan(y_mn))));
y_dmn = zeros(size(y),classname)+nan;
y_dmn(ind)=y(ind)-y_mn(ind);

% Make it back to input dimensions %
if length(sz)>2
  y_dmn  = reshape(y_dmn, sz);
  y_mn12 = reshape(y_mn12,[sz(1:end-1),12]);
  y_mn   = reshape(y_mn,  sz);
end

end

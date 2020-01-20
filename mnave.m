function y_mn = mnave(t,y,nan,W)

if nargin<2
  nan=NaN;
end

% weighting; if not supplied, put them as ones %
if nargin<4, W=ones(size(y)); end
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

t=365*(t-floor(t))+1;
[yr mn dy]=datevec(double(t));
y_mn = zeros(size(y,1),12);
for j=1:12
  ind = find(j==mn);
  if ~isempty(find(y(:,ind)~=nan & ~isnan(y(:,ind))))
    [ignore dummy] = nancenter(y(:,ind),nan,2,W(:,ind));
    y_mn(:,j)=dummy;
  else
    y_mn(:,j)=nan;
  end
end

% Make it back to input dimensions %
if length(sz)>2
  y_mn = reshape(y_mn,[sz(1:end-1),12]);
end

end

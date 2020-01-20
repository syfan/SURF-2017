function [Xc,Xm,std,stderr,effcnt,cnt,Xs]=nancenter(X,nan,dim,w0,options)
% Centering of data, ignoring NaN's.
% X must be 2D. The 1st dim is time; the 2nd dim is space.
% W must have the same dim of X, which carries the weight
% of each data point.

% Determine whether it is single-precision or double-precision %
classname=whos('X');
classname=classname.class;

if nargin<5
  fopts=[];
else
  fopts=fieldnames(options);
end

if nargin<4
  w0=ones(size(X),classname);
end

if nargin<3
  dim=1;
end

if nargin<2
  nan=NaN;
end

if length(size(X))<2,error('X must be greater than 2D');end;

%%%  Make the matrix 2D %%%
% Transpose index %
if dim<0
  error('dim must be > 0');
end
if dim>1
  t_ind       =1:length(size(X));
  t_ind(1)    =dim;
  t_ind(2:dim)=t_ind(2:dim)-1;
  X =permute(X, t_ind);
  w0=permute(w0,t_ind);
end
% Size of X %
sz = size(X);
nt = sz(1);  m=prod(sz(2:length(sz)));

% Make it 2D %
if length(sz)>2
  X  = reshape(X,nt,m);
  w0 = reshape(w0,nt,m);
end

% Use weight to ignore NaN's %
ind_bad = uint32(find(X==nan | isnan(X)));
w0(ind_bad)=0;
if max(w0(:))==0
  warning('Null data set')
  Xc     = zeros(sz,classname)+nan;
  Xm     = zeros(sz(2:length(sz)),classname)+nan;
  std    = zeros(sz(2:length(sz)),classname)+nan;
  stderr = zeros(sz(2:length(sz)),classname)+nan;
  effcnt = zeros(sz(2:length(sz)),classname);
  cnt    = zeros(sz(2:length(sz)),classname);
end

% Normalize to give effective number of sample %
if strmatch('normwgt', fopts)
  if max(min(w0))~=max(max(w0))
    maxv=max(w0);
    idc1=find(maxv~=0); cc1=length(idc1);
    w0(:,idc1) = w0(:,idc1)./repmat(maxv(idc1),nt,1);
  end
end

% effective count %
effcnt = sum(w0);
id2=find(effcnt==0); effcnt(id2)=eps; % For division only

% Number count %
cnt = full(sum(spones(w0)));

% Sum %
Xs = nansum(X.*w0);

% Mean %
Xm = Xs./effcnt;
std = sqrt(( nansum(X.*X.*w0)./effcnt - Xm.^2 ) ./( 1 - 1./effcnt ));
stderr = std./sqrt(effcnt);

% Reset NaN values %
Xs(id2)=nan; Xm(id2)=nan; std(id2)=nan; stderr(id2)=nan; effcnt(id2)=0;

% Remove the center %
Xc=X-repmat(Xm,nt,1);
Xc(ind_bad)=nan;

% Make it back to input dimensions %
if length(sz)>2
  Xc     = reshape(Xc,    sz);
  Xm     = reshape(Xm,    sz(2:length(sz)));
  std    = reshape(std,   sz(2:length(sz)));
  stderr = reshape(stderr,sz(2:length(sz)));
  effcnt = reshape(effcnt,sz(2:length(sz)));
  cnt    = reshape(cnt,   sz(2:length(sz)));
end
if dim>1
    [dummy,acn_ind]=sort(t_ind);
    Xc=permute(Xc,acn_ind);
end

end


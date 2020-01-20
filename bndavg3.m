function yavg=bndavg3(lat,y,latlim,nan)

  % Inputs:
  % nan = values of Not-a-Number (Default=NaN)
  % y = y[lon,lat,t]
  % lat = lat[nlat,1]

  if nargin<4
    nan=NaN;
  end

  sz = size(lat);
  if min(sz)~=1, error('lat must be an array'); end
  if sz(2)~=1, lat=lat'; end

  if numel(latlim)~=2, error('latlim must have two elements'); end
  
  % Averaging lon and lat together %
  nt=size(y,3);  nlon=size(y,1);
  ind  = find(lat >= min(latlim(:)) & lat <= max(latlim(:)));
  if isempty(ind), error('wrong latitude range'); end
  lat  = lat(ind);  nlat=length(lat);
  y    = y(:,ind,:);

  % cosine latitude weighting
  w = repmat(cos(pi*lat/180.),[nlon,nt]);
  w = permute(w,[2,1,3]);

  % Degenerate the lat and lon dimensions
  y = reshape(y,nlon*nlat,nt);
  w = reshape(w,nlon*nlat,nt);

  maxy=nanmax(y(:));   miny=nanmin(y(:));
  if maxy==miny && maxy==nan | (isnan(maxy) && isnan(miny))
    yavg=ones(1,nt)*nan;
  else
    [ignored,yavg] = nancenter(y,nan,1,w);
  end

return

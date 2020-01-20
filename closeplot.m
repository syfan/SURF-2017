function closeplot(png)
global nplt_  plotn_  jplt_  nrow_  ncol_ ftsz_ h_
  %pdfcrop(h_)
  type={'.ps';'.png';'.jpg';'.pdf';'.eps'};
  [path,filert,ext]=fileparts(plotn_);
  if isempty(path),path='.';end
  if ~exist('png'),png=0;end
  if png > 4 | png < 0, png=0; end
  if png==1
    print('-dpng',[path '/' filert type{png+1}]);
  elseif png==2
    print('-djpeg',[path '/' filert type{png+1}]);
  elseif png==3
    print('-dpdf',[path '/' filert type{png+1}]);
  elseif png==4
    print('-depsc',[path '/' filert type{png+1}]);
  else
    if jplt_<=nplt_, print('-dpsc',plotn_); end;
    if jplt_>nplt_, print('-dpsc','-append',plotn_); end;
    system(['ps2pdf ' plotn_ ' ' path '/' filert '.pdf']);
    delete(plotn_);
    type{png+1}='.pdf';
  end
  disp([path '/' filert  type{png+1} ' ready'])

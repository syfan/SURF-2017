function h_ = initplot(plotn,nrow,ncol,ftsz)
global nplt_  plotn_  jplt_  nrow_  ncol_ ftsz_ h_

if ~exist('ftsz')
  ftsz_ = 14; % fontsize
else
  ftsz_=ftsz;
end

% Change default axes fonts.
%set(0,'DefaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', ftsz_)
%set(0,'DefaultTextFontname', 'Times New Roman')
set(0,'DefaultTextFontSize', ftsz_)
set(0,'DefaultLineLineWidth',1)
set(0,'DefaultLineMarkerSize',3)
%set(0,'DefaultAxesLooseInset',[0,0,0,0])

plotn_ = plotn;
[dum1,filert,ext]=fileparts(plotn_);
if strcmp(ext,'.pdf')
  plotn_=[dum1 '/' filert '.ps'];
  [dum1,filert,ext]=fileparts(plotn_);
end
if ~strcmp(ext,'.ps')
  plotn_=[plotn_ '.ps'];
end

jplt_=0;

if ~exist('nrow')
  nrow_=2;
else
  nrow_=nrow;
end

if ~exist('ncol')
  ncol_=1;
else
  ncol_=ncol;
end


nplt_=nrow_*ncol_; % Number of plots in one page
close
h_ = figure('visible','off','PaperSize',[8 11],'PaperPosition',[0.1 0.1 7.8 10.8]);

end

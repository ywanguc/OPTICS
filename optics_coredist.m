function optics_coredistances=optics_coredist(datafile, MinPts)
% function optics_coredistances=optics_coredist(datafile, MinPts) calculates the
% core-distance of points in datafile specified by MinPts. It returns a
% matrix. The first column is the index of the points, the second column is
% the core-distances, the third and fourth columns are the x-y coorediates
% of the points.    

% Author: Yong Wang
% Date:   Dec 2013
%

% if nargin<3, eps=1; end;
if nargin<2, MinPts=7; end;
if nargin<1, error('Usage: optics_result=optics_alg(datafile, MinPts)'); end;

%% load data
pos=load(datafile);
% figure(1);clf;
% plot(pos(:,1), pos(:,2),'.');

%% prepare distants
Dtr=pdist(pos);
D=squareform(Dtr);

%% OPTICS CORE-DISTANCE
nPts=size(pos,1);
if (MinPts>nPts)
    error('Error: MinPts>nPts');    
end
optics_coredistances=zeros(nPts, 4);
idx=reshape(1:nPts,[],1);
coredist=zeros(nPts,1);
for i=1:nPts
    dist=D(i,:);    
    sortedDist=sort(dist);
    coredist(i)=sortedDist(MinPts);
    optics_coredistances(i,:)=[i, coredist(i), pos(i,1), pos(i,2)];
end
% figure(2);clf;
% plot(idx, coredist,'g-');
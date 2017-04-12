% check contact spacing
for i=1:(length(CortElecLoc)-1)
    fprintf('Dist %d-%d: %4.2f\n', i, i+1, pdist2(CortElecLoc{i}, CortElecLoc{i+1}));
end

firstelec = 3;
lastelec = 4;
fprintf('Dist %d-%d: %4.2f\n', 1, 14, pdist2(CortElecLoc{1}, CortElecLoc{14}));
fprintf('Dist %d-%d: %4.2f\n', 15, 28, pdist2(CortElecLoc{15}, CortElecLoc{28}));

figure; plot3(mask_indices(:,1), mask_indices(:,2), mask_indices(:,3), 'g.')
axis equal
camlight('headlight','infinite');
% use brush tool to select a segment of the hull --> l
l0 = l;
figure; plot3(l(:,1), l(:,2), l(:,3), 'g.')
axis equal
camlight('headlight','infinite');

elec = reshape(cell2mat(CortElecLoc0),3,length(CortElecLoc0))';
hold on; plot3(elec(:,1), elec(:,2), elec(:,3), 'r.', 'MarkerSize', 25)

pos1=get(gca,'CurrentPoint');
hold on; plot3(pos1(:,1), pos1(:,2), pos1(:,3), 'm');

norm = cross(pos1(2,:)-elec(firstelec,:), pos1(2,:)-elec(lastelec,:));

clear v
for i= 1:length(l)
    v(i) = dot(l(i,:)-pos1(2,:),norm);
end

hull_res = 2.5e2;
%hull_res = 3e2;
l(find( abs(v)>hull_res),:)=[];

path=1;
for i=1:length(l)-1
    nodes = setdiff(1:length(l),path);
    [~,idx] = pdist2(l(nodes,:), l(path(end),:), 'euclidean', 'smallest', 1);
    path = cat(1, path, nodes(idx));
end
l=l(path,:);

s=cscvn(l');
hold on; fnplt(s, 'm', 2)

brk=1;
while ~(isequal(fnval(s, s.breaks(brk)), elec(firstelec,:)') || ...
        isequal(fnval(s, s.breaks(brk)), elec(lastelec,:)'))
brk = brk+1;
end
brk1 = brk; 
brk = brk+1;
while ~(isequal(fnval(s, s.breaks(brk)), elec(firstelec,:)') || ...
        isequal(fnval(s, s.breaks(brk)), elec(lastelec,:)'))
brk = brk+1;
end
brk2 = brk;

elec_line=fnval(s, linspace(s.breaks(brk1),s.breaks(brk2),400))';

%elec_num = size(elec,1);
elec_num = lastelec-firstelec+1;
ElecEq = SubCurve( elec_line, elec_num );
hold on; plot3(ElecEq(:,1), ElecEq(:,2), ElecEq(:,3), 'b.', 'MarkerSize', 25)

CortElecLoc = mat2cell(ElecEq, ones(elec_num,1), 3)';
% check if electrode contact order got switched; if so, reverse order 
if isequal(CortElecLoc0{firstelec}, CortElecLoc{1})
    fprintf('Electrode order switched.\n')
    CortElecLoc = CortElecLoc(elec_num:-1:1);
end

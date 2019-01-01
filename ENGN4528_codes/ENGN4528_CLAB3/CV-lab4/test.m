clc
clear

actualColumnIndex = 7.932444e+01;
% tempRow = 9.621568e+01;
% tempColumn = 5.411492e+02;

theta = 10;
tform = projective2d([cosd(theta) -sind(theta) 0.001; sind(theta) cosd(theta) 0.01; 0 0 1]);

[sourceRowIndex, sourceColumnIndex] = transformPointsInverse(tform, 29, actualColumnIndex);

[targetRowIndex, targetColumnIndex] = transformPointsForward(tform, sourceRowIndex, sourceColumnIndex);
% 
% % fprintf('targetColumnIndex is %d\n', targetColumnIndex);
% % targetColumnIndex = targetColumnIndex + rows*sind(theta);
% % 
% % fprintf('targetRowIndex is %d\n', targetRowIndex);
% % fprintf('targetColumnIndex is %d\n', targetColumnIndex);
% % 
% % actualRowIndex = targetColumnIndex;
% % targetColumnIndex = targetColumnIndex - rows*sind(theta);
% % 
% % fprintf('targetColumnIndex is %d\n', targetColumnIndex);
% 
% rows = 240;
% 
% for index = 1 : rows
% 
%     temp =  index - rows*sind(theta);
% 
%     [sourceRowIndex, sourceColumnIndex] = transformPointsInverse(tform, temp, 1);
%     
%     if fix(sourceRowIndex) <= 0
%         display(index);
%         continue
%     end
%     
% end
% 
% 
% % temp =  1- rows*sind(theta);
% % 
% % [sourceRowIndex2, sourceColumnIndex2] = transformPointsInverse(tform, temp, 1);
% 
% % fprintf('sourceRowIndex2 is %d\n', sourceRowIndex2);
% % fprintf('sourceColumnIndex2 is %d\n', sourceColumnIndex2);
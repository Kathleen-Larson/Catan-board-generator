clear; close all

%% Create the board

resources = {'sheep' 'sheep' 'sheep' 'sheep' ...
             'wheat' 'wheat' 'wheat' 'wheat' ...
             'wood'  'wood'  'wood'  'wood'  ...
             'brick' 'brick' 'brick'         ...
             'ore'   'ore'   'ore'           ...
             'desert'}';

n = length(resources);
inds_resources = randperm(n);
tile = 0;

% Tile vertices
xhex = [0 0 1 2 2 1];
yhex = [1 2 3 2 1 0];

for ii = 1:7
    i = ii-1;
    for jj = 1:7
        j = jj-1;
        % Is the index actually on the board?
        if (i==1 && ismember(j,2:4)) || ...
                (i==2 && ismember(j,1:5)) || ...
                (i==3 && ismember(j,1:5)) || ...
                (i==4 && ismember(j,1:5)) || ...
                (i==5 && j==3)
            loc = 'on';
            tile = tile + 1;
        else
            loc = 'off';
        end
        
        % Get tile color
        if strcmp(loc,'on') % if on the board
            if strcmp(resources{inds_resources(tile)},'sheep')
                C = [173 255 47]/255;
            elseif strcmp(resources{inds_resources(tile)},'wheat')
                C = [255 215 0]/255;
            elseif strcmp(resources{inds_resources(tile)},'wood')
                C = [34 139 34]/255;
            elseif strcmp(resources{inds_resources(tile)},'brick')
                C = [205 55 0]/255;
            elseif strcmp(resources{inds_resources(tile)},'ore')
                C = [70 100 100]/255;
            elseif strcmp(resources{inds_resources(tile)},'desert')
                C = [222 184 135]/255;
            end
        elseif strcmp(loc,'off')
            C = [28 134 238]/255;
        end
        
        % Plot
        p = patch((xhex + mod(jj,2)) + 2*i,yhex + 2*j,C);
        if tile > 0 && strcmp(resources{inds_resources(tile)},'desert')
            nonumspot = p.Vertices;
        end
        hold on
    end
end
axis off
title('Happy settling!')


%% Put numbers on all the tiles

numbers = {'2' '3' '3' '4' '4' '5' '5' '6' '6' '8' '8' '9' '9' '10' ...
           '10' '11' '11' '12'};
numlocs = [5 3.5; 7 3.5; 9 3.5; 4 5.5; 6 5.5; 8 5.5; 10 5.5; 3 7.5; ...
           5 7.5; 7 7.5; 9 7.5; 11 7.5; 4 9.5; 6 9.5; 8 9.5; 10 9.5; ...
           5 11.5; 7 11.5; 9 11.5];
nonumloc = [nonumspot(3,1) (nonumspot(1,2)+nonumspot(2,2))/2];
inds_numbers = randperm(n-1);

for ii = 1:n
    if isequal(numlocs(ii,:),nonumloc)
        numlocs(ii,:) = [];
        break
    end
end

text(numlocs(inds_numbers,1),numlocs(inds_numbers,2),numbers,...
    'HorizontalAlignment','center')



%% Add ports
       
ports = {'sheep' '?' 'wheat' '?' 'wood' '?' 'brick' '?' 'ore'}';

portlocs = [1 7.5; 3 11.5; 6 13.5; 10 13.5; 12 9.5; 12 5.5; 10 1.5; ...
            6 1.5; 3 3.5];
np = length(portlocs);
inds_port = randperm(np);

text(portlocs(inds_port,1),portlocs(inds_port,2),ports,...
    'HorizontalAlignment','center')



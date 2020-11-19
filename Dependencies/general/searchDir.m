function [files,idx] = searchDir(fileStruct,chCell)
% fileStruct is struct obtained after running the command dir
% chCell can be a character or a cell array of characters to match with the
% fileStruct
% RS - 02/13/16
N = length(fileStruct);

if ~iscell(chCell)
    text = chCell;
    chCell = cell(1,1);
    chCell{1,1} = text;
end

nTags = length(chCell);
files = struct;
idx = [];

for i=1:N
    ck = 0;
    for j=1:nTags
        temp = strfind(fileStruct(i).name,chCell{j});
        if ~isempty(temp)
            ck = ck+1;
        end
    end
    if (ck==nTags)
        idx = cat(1,idx,i);
        files(length(idx)).name = fileStruct(i).name;
    end
end

files = reshape(struct2cell(files),1,[]);
if isempty(idx)
    warning('no matching files found!');
end
    
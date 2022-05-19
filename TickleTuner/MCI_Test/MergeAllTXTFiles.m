clear, close  all

folderContent = dir(strcat(pwd, '\Lists\*.txt'));

fileID = fopen("AllSounds.txt", "w");

content = [];

for idx = 1 : size(folderContent, 1)
    pointedFile = strcat(pwd, '\Lists\', folderContent(idx).name);
    fileOpen = fopen(pointedFile, "r");
    %     cellContent = textscan(fileOpen, "%s\r\n");
    %     content = char(content, char(cellContent{:}));
    content = fscanf(fileOpen, '%c');
    fprintf(fileID, '%c', content);
    fclose(fileOpen);
end



fclose(fileID);
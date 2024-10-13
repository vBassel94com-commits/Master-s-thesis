c=num2cell(codeword,8);


LastName = c;
Char = 1:5;
Char=Char';
double = 1:5;
double=double';
cell = 1:5;
cell=cell';
T = table(Char,double,cell,'RowNames',LastName);
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,...
    'RowName',T.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);
% ŞÑÇÁÉ ÇáßáãÉ ÇáãÓÊåÏİÉ ãä ãáİ äÕí
fileID = fopen('encoded_text.txt', 'r');
targetPassword = fscanf(fileID, '%s');
fclose(fileID);

% ÚÏÏ ÇáãÍÇæáÇÊ ÇáãÓÊåÏİ
maxAttempts = 1000000;

% ÈÏÁ åÌæã ÇáÈÍË ÇáÚÔæÇÆí
found = false;
attempts = 0;

while ~found && attempts < maxAttempts
    % ÊæáíÏ ßáãÉ ãÑæÑ ÚÔæÇÆíÉ ÈäİÓ ÚÏÏ ÇáÃÍÑİ İí ÇáßáãÉ ÇáãÓÊåÏİÉ
    generatedPassword = char(randi([97, 122], 1, numel(targetPassword)));
    
    % ÒíÇÏÉ ÚÏÏ ÇáãÍÇæáÇÊ
    attempts = attempts + 1;
    
    % ÇáÊÍŞŞ ãä ãØÇÈŞÉ ßáãÉ ÇáãÑæÑ ÇáãÓÊåÏİÉ
    if isequal(generatedPassword, targetPassword)
        found = true;
    end
end

if found
    disp(['Êã ÇáÚËæÑ Úáì ßáãÉ ÇáãÑæÑ ÈÚÏ ', num2str(attempts), ' ãÍÇæáÉ.']);
    disp(['ßáãÉ ÇáãÑæÑ åí: ', generatedPassword]);
else
    disp('áã íÊã äÌÇÍ ÇáåÌæã. ÊãÊ ÇáãÍÇæáÇÊ ÇáÜ 1000 Ïæä ÇáÚËæÑ Úáì ÇáßáãÉ ÇáãÓÊåÏİÉ.');
end
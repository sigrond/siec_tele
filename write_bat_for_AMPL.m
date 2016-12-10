function [ output_args ] = write_bat_for_AMPL( AMPLpath, model_name, data_name, run_name )
%write_bat_for_AMPL wygeneruje plik wsadowy
%   bat pozwoli wywo�a� ampla we w�a�ciwym katalogu wraz z w�a�ciwymi
%   argumentami. przekopiuje pliki modelu danych i run, a nast�pnie zwr�ci
%   do w�a�ciwego katalogu odpowied� i posprz�ta po sobie

f=fopen('a1.bat','w');
fprintf(f,'copy ');
fprintf(f,model_name);
fprintf(f,' "');
fprintf(f,'%s',AMPLpath);
fprintf(f,'"\n');
fprintf(f,'copy ');
fprintf(f,data_name);
fprintf(f,' "');
fprintf(f,'%s',AMPLpath);
fprintf(f,'"\n');
fprintf(f,'copy ');
fprintf(f,run_name);
fprintf(f,' "');
fprintf(f,'%s',AMPLpath);
fprintf(f,'"\n');
fprintf(f,'cd "');
fprintf(f,'%s',AMPLpath);
fprintf(f,'"\n');
fprintf(f,'ampl.exe run.run > out\n');
fprintf(f,'copy out "%%~f0\\..\\"\n');

fclose(f);

end


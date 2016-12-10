function [ output_args ] = write_bat_for_AMPL( AMPLpath, model_name, data_name, run_name )
%write_bat_for_AMPL wygeneruje plik wsadowy
%   bat pozwoli wywo³aæ ampla we w³aœciwym katalogu wraz z w³aœciwymi
%   argumentami. przekopiuje pliki modelu danych i run, a nastêpnie zwróci
%   do w³aœciwego katalogu odpowiedŸ i posprz¹ta po sobie

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


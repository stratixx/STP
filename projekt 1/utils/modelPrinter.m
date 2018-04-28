function [  ] = modelPrinter( name )
% Drukuje model do modele/name.png

load_system(name)
path = '../modele/';
print( '-dpng', strcat('-s', name), strcat(path,strrep(name,'/','_'),'.png'))

end


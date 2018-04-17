function [  ] = println( text, beQuiet )
    if ~exist('beQuiet') | ~beQuiet
        disp(text);
    end
end
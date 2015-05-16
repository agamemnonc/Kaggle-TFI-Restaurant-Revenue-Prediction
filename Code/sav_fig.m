% SAV_FIG saves current figure in .png and .fig formats.
% Inputs
%   savFold:            Folder
%   savStr:             Filename
% Outputs: none
% Dependencies: export_fig

% Author: Agamemnon Krasoulis
% agamemnon.krasoulis@gmail.com
%
% 01/04/15 AK First created

function sav_fig(savFold, savStr)

if nargin < 2
    error('Invalid number of input arguments.')
end

savFolder = strcat(rrp_general_folder, '/', savFold);
mkdir(savFolder)
saveas(gcf,strcat(savFolder, '/', savStr))
export_fig temp -png 
movefile('temp.png', strcat(savFolder, '/', savStr, '.png'))

end % EOF
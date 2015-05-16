% Write results to submission file

function write_results(Prediction,sub_number)

hostname = char(getHostName(java.net.InetAddress.getLocalHost));
switch hostname 
    case 'Agamemnon-IF' % Office PC
        fileName = strcat(rrp_general_folder, '\#Submissions\','sub', num2str(sub_number), '.csv');
    case {'hubel.inf.ed.ac.uk', 'wiesel.inf.ed.ac.uk', ...
            'jupiter1.inf.ed.ac.uk', 'jupiter2.inf.ed.ac.uk', ...
            'jupiter3.inf.ed.ac.uk', 'agamemnons-mbp', ...
            'Agamemnons-MacBook-Pro.local'} % Unix
        fileName = strcat(rrp_general_folder, '/#Submissions/','sub', num2str(sub_number), '.csv');
end
Id = (0:1:99999)';
T = table(Id, Prediction);

writetable(T,fileName)

% EOF
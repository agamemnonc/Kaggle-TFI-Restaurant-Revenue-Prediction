% Returns the general folder for the RRP competition

function rootFold = rrp_general_folder

hostname = char(getHostName(java.net.InetAddress.getLocalHost));
switch hostname 
    case 'Agamemnon-IF' % Office PC
        rootFold = 'C:\Users\Agamemnon\DTC\Kaggle Competitions\Restaurant Revenue Prediction';
    case {'hubel.inf.ed.ac.uk', 'wiesel.inf.ed.ac.uk'} % Hubel and Wiesel
        rootFold = '/disk/data1/s1230917/RRP';
    case {'jupiter1.inf.ed.ac.uk', 'jupiter2.inf.ed.ac.uk', 'jupiter3.inf.ed.ac.uk'} % Jupiter servers
    case {'agamemnons-mbp', 'Agamemnons-MacBook-Pro.local'}
        rootFold = '/Users/agamemnon/Google Drive/DTC/Kaggle Competitions/Restaurant Revenue Prediction';
    otherwise
        error('Unknown data folder path for current machine');
end

end % EOF
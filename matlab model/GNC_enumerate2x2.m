function GNCout = GNC_enumerate(GNC)

% GNC systems architecture generation and evaluation
%global NSMAX NCMAX SENSORS COMPUTERS INTERCONNECTIONS M_SENS M_COMP R_SA R_SB R_SC R_CA R_CB R_CC R_I




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENUMERATE ARCHITECTURES
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose scaling factors
GNC = ScaleMass2x2(GNC,'fix');

% Choose Nsensors
GNCout = ChooseNS(GNC);
GNC2 = GNCout;

% Choose Ncomputers
GNCout = ChooseNC(GNC2);
GNC3 = GNCout;

% Choose type of sensors
GNCout = ChooseSensors2x2(GNC3);
GNC4 = GNCout;

% Choose type of computers
GNCout = ChooseComputers2x2(GNC4);
GNC5 = GNCout;

% Interconnect sensors and computers
GNCout = ConnectS12x2(GNC5);
GNC6 = GNCout;

GNCout = ConnectS22x2(GNC6);
GNC7 = GNCout;
% 
% GNCout = ConnectS3(GNC7);
% GNC8 = GNCout;

% Save enumeration results in a file

%results2CSV(GNC8);
return



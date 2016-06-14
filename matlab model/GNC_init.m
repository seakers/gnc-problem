function GNC = GNC_init()
global NSMAX NCMAX DCP
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSTANTS
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NSMAX = 3;
NCMAX = 3;
% NAMAX = 3;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIALIZE STRUCTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parameters
GNC.M_S0                        = 6;
GNC.R_S0                        = 0.999;
GNC.M_C0                        = 5;
GNC.R_C0                        = 0.9996;
GNC.M_I0                        = 0;
GNC.R_I0                        = 1;
GNC.SensorMassScalingFactor     = 1;   %k
GNC.SensorMassSpacingFactor     = 0.5; %r
GNC.SensorReliabScalingFactor   = 1;   %alfa: k' = k/alfa*{1-r, r, 1+r}
GNC.CompMassScalingFactor       = 1;
GNC.CompMassSpacingFactor       = 0.5;
GNC.CompReliabScalingFactor     = 1;
GNC.DissimilarComponentPenalty  = 0;
% Design vector
GNC.M_SA                        = [];
GNC.M_SB                        = [];
GNC.M_SC                        = [];

GNC.R_SA                        = [];
GNC.R_SB                        = [];
GNC.R_SC                        = [];

GNC.M_CA                        = [];
GNC.M_CB                        = [];
GNC.M_CC                        = [];

GNC.R_CA                        = [];
GNC.R_CB                        = [];
GNC.R_CC                        = [];

% GNC.M_AA                        = [];
% GNC.M_AB                        = [];
% GNC.M_AC                        = [];
% 
% GNC.R_AA                        = [];
% GNC.R_AB                        = [];
% GNC.R_AC                        = [];

GNC.NS                          = [];
GNC.NC                          = [];
GNC.NA                          = [];
GNC.sensors                     = [];
GNC.computers                   = [];
% GNC.actuators                   = [];
GNC.Ibin                        = [];
GNC.Inat                        = [];
% GNC.Ibin2                       = [];
% GNC.Inat2                       = [];

% Outputs
GNC.m                           = [];
GNC.R                           = [];
GNC.N9                          = [];
GNC.MTTF                        = [];
GNC.Nlinks                      = [];
GNC.Fields                      = [];
return
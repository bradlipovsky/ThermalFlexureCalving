%
% This script contains the four borehole temperature profiles plotted
% in Lipovsky (2019), "Thermal flexure and glacier calving".  These
% are each previously published elsewhere but they are given here to
% ease reproducibility.  This script also calculates moments and stresses
% for the Jakobshavn profile.
%

clear;

z = 0:0.01:1;
plot(z.^1,z,'-k','linewidth',1); hold on;
plot(z.^(1/2),z,'-k','linewidth',1);
plot(z.^(1/4),z,'-k','linewidth',1);
plot(z.^(1/8),z,'-k','linewidth',1);
plot(z.^(1/16),z,'-k','linewidth',1);

%
% LAV profile, digitized from the figure in Bender and Gow (1961)
%
lav = [
40 -21.5
60 -21.5
85 -21
95 -21
110 -20.5
120 -20
140 -19
150 -17.5
170 -16
190 -15
200 -13
220 -10
230 -8
240 -7
250 -5
260 -2];

%
% PIG profile as published on NSIDC by Truffer
%

pig = ...
[    2.0000    1.6675
    4.0000  -10.2043
    6.0000  -18.4398
    8.0000  -19.9307
   10.0000  -20.5329
   12.0000  -20.8759
   22.0000  -21.8088
   32.0000  -21.8561
   42.0000  -21.9746
   52.0000  -21.8530
   62.0000  -22.0491
   72.0000  -21.8785
   82.0000  -22.0410
   92.0000  -21.7808
  102.0000  -21.8557
  112.0000  -20.3877
  460		-22];
% first column is height above ice bottom.  Last entry is manually added.


%
% Ross J9 temperature profile as published on NSIDC
%

j9=[ 25	 -26.44;...
50	 -25.33;...
75	 -24.26;...
100	 -23.12;...
136      -21.43;...
230.5    -15.93;...
265.7	 -13.62;...
310.0	 -10.47;...
330.3	 -9.02;...
420.0	 -2.19];

%
% Jakobshavn temperature profile as published by Iken et al 1993
%

jk = [20 -6.17;...
100 -14.55;...
200 -17.82;...
258.1 -18.22;...
300 -19.71;...
344.1 -19.74;...
450 -20.83;...
525 -22.39;...
544.9 -21.61;...
559.3 -21.22;...
600 -20.06;...
645.2 -17.96;...
650 -16.35;...
659.6 -16.62;...
745.4 -5.74;...
759.9 -3.39;...
789.1 -1.05;...
795.5 -0.73;...
799.1 -0.56;...
809.1 -0.59;...
820.6 -0.6;...
827.6 -0.58;...
828.5 -0.59;...
829.4 -0.59;...
830.0 -0.59;...
831.9 -0.59;...
832.8 -0.58;...
1432 0];


plot(j9(:,2)/j9(1,2), 1-j9(:,1)/j9(end,1),'o','linewidth',2)
plot(pig(:,2)/min(pig(:,2)),pig(:,1)/max(pig(:,1)),'o','linewidth',2); hold on;
plot(lav(:,2)/min(lav(:,2)),1-lav(:,1)/max(lav(:,1)),'o','linewidth',2); hold on;
plot(jk(:,2)/min(jk(:,2)),1-jk(:,1)/max(jk(:,1)),'ok','linewidth',2); hold on;
line(xlim,[0.9 0.9],'linesty','--','Color','k');
xlabel('Temperature, T/T_s');
ylabel('Depth, z/h');
xlim([0 1]);

h = 1432;
z = 20:0.1:h;
d = interp1(jk(:,1),jk(:,2),z);


% Stretch the profile to be of height h=833
z = z/h * 833;
h=833;
z = h-z;
% No thermal expansion above the water line!
d (z>h*.9) = 0;

Ep = 9e9/(1-0.3);
alpha=5e-5;

mT = trapz( z,  d.*(z - h/2)  ) * Ep * alpha / 1e9;
sT = trapz( z,  d  ) * Ep * alpha /h / 1e6;
disp(['At Jakobshavn: mT=' num2str(mT) ' and sigT= ' num2str(sT)]);


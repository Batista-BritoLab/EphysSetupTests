% This m-file uses the toolbox provided by Stujenske et al., 2015 (Cell
% Reports) to generate Light Intensity and Heat distribution. Fiber
% diameter, fiber NA, wavelength, fiber output power coud be set. To check
% specific light intensity and heat increases, change the powerDepthMonitor
% and degreeMonitor variables.

clear all

fiber_d = 0.062; %0.2 fiber coupled LEDs from thorslab
fiber_NA = 0.22; %0.22
wavelength = 470;

output_power = 20; %mW %4.4
maximumPowerDensity = output_power/(pi*(fiber_d/2)^2);



powerDepthMonitor1 = 10; %mW/mm2
relativePowerDepthMonitor1 = powerDepthMonitor1/maximumPowerDensity;

powerDepthMonitor2 = 3; %mW/mm2
relativePowerDepthMonitor2 = powerDepthMonitor2/maximumPowerDensity;


degreeMonitor1 = 1;
degreeMonitor2 = 7;

[frac_abs,frac_trans,params,r,depth]=MonteCarloLight(1,fiber_d/2,fiber_NA,wavelength,100,[-.2,0,1.5],1,0.01);



figure;
% plot_mat = log10(frac_trans./max(frac_trans(:)));
plot_mat = frac_trans./max(frac_trans(:));

surf([-r(end:-1:2) r],depth,[plot_mat(:,end:-1:2) plot_mat],'EdgeColor','interp','FaceColor','interp','FaceLighting','phong');
axis ij; 
axis tight;
hold on
contour3([-r(end:-1:2) r],depth,[plot_mat(:,end:-1:2) plot_mat],[relativePowerDepthMonitor1,relativePowerDepthMonitor1],'Color','yellow');
contour3([-r(end:-1:2) r],depth,[plot_mat(:,end:-1:2) plot_mat],[relativePowerDepthMonitor2,relativePowerDepthMonitor2],'Color','yellow');
ylabel('Depth (mm)')
xlabel('r (mm)')
view(0,90);

t_on = 0;
t_off = 5;
t_max = t_off;
Power = output_power;
t_save = t_off;
[u_time,u_space,t,r,depth]=HeatDiffusionLight(frac_abs,params,0.03,t_on,t_off,t_max,Power,t_save,0.25);


figure;
plot_mat = u_space;
surf([-r(end:-1:2) r],depth,[plot_mat(:,end:-1:2) plot_mat],'EdgeColor','interp','FaceColor','interp','FaceLighting','phong');
axis ij; 
axis tight;
hold on
contour3([-r(end:-1:2) r],depth,[plot_mat(:,end:-1:2) plot_mat],[degreeMonitor1,degreeMonitor1],'Color','red');
contour3([-r(end:-1:2) r],depth,[plot_mat(:,end:-1:2) plot_mat],[degreeMonitor2,degreeMonitor2],'Color','red');
ylabel('Depth (mm)')
xlabel('r (mm)')
view(0,90);
% Code to calculate the 4-3-4 trajectory
theta = [30 0 0 50 50 0 0 90 90 0 0 70 0 0]';
t1 = 2;
t2 = 4;
t3 = 2;

% Populate M matrix
M = zeros(14,14);
M(1,1) = 1;
M(2,2) = 1;
M(3,3) = 2;
M(4,1) = 1; M(4,2) = t1; M(4,3) = t1^2; M(4,4) = t1^3; M(4,5) = t1^4;
M(5,6) = 1;
M(6,2) = 1; M(6,3) = 2*t1; M(6,4) = 3*(t1^2); M(6,5) = 4*(t1^3); M(6,7) = -1; 
M(7,3) = 2; M(7,4) = 6*t1; M(7,5) = 12*(t1^2); M(7,8) = -2; 
M(8,6) = 1; M(8,7) = t2; M(8,8) = (t2^2); M(8,9) = (t2^3); 
M(9,10) = 1;
M(10,7) = 1; M(10,8) = 2*t2; M(10,9) = 3*(t2^2); M(10,11) = -1; 
M(11,8) = 2; M(11,9) = 6*t2; M(11,12) = -2;
M(12,10) = 1; M(12,11) = t3; M(12,12) = t3^2; M(12,13) = t3^3; M(12,14) = t3^4;
M(13,11) = 1; M(13,12) = 2*t3; M(13,13) = 3*(t3^2); M(13,14) = 4*(t3^3);
M(14,12) = 2; M(14,13) = 6*t3; M(14,14) = 12*(t3^2);

% Calculate C
C = M\theta;

% Calculate angular position, velocity, acceleration
ta = linspace(0,t1,10);
tb = linspace(0,t2,10);
tc = linspace(0,t3,10);
theta_a = C(1)+C(2)*ta+C(3)*ta.^2+C(4)*ta.^3+C(5)*ta.^4;
theta_b = C(6)+C(7)*tb+C(8)*tb.^2+C(9)*tb.^3;
theta_c = C(10)+C(11)*tc+C(12)*tc.^2+C(13)*tc.^3+C(14)*tc.^4;
dtheta_a = C(2)+2*C(3)*ta+3*C(4)*ta.^2+4*C(5)*ta.^3;
dtheta_b = C(7)+2*C(8)*tb+3*C(9)*tb.^2;
dtheta_c = C(11)+2*C(12)*tc+3*C(13)*tc.^2+4*C(14)*tc.^3;
ddtheta_a = 2*C(3)+6*C(4)*ta+12*C(5)*ta.^2;
ddtheta_b = 2*C(8)+6*C(9)*tb;
ddtheta_c = 2*C(12)+6*C(13)*tc+12*C(14)*tc.^2;

% Plot position, velocity, acceleration
figure
plot(ta,theta_a,'-k','LineWidth',2)
hold on
plot(t1+tb,theta_b,'-k','LineWidth',2)
plot(t1+t2+tc,theta_c,'-k','LineWidth',2)
grid on
xlim([0 t1+t2+t3])
plot(t1*[1 1],[0 max(theta)],'--r','LineWidth',2)
plot((t1+t2)*[1 1],[0 max(theta)],'--r','LineWidth',2)
plot(ta,dtheta_a,'-b','LineWidth',2)
plot(t1+tb,dtheta_b,'-b','LineWidth',2)
plot(t1+t2+tc,dtheta_c,'-b','LineWidth',2)
plot(ta,ddtheta_a,'-r','LineWidth',2)
plot(t1+tb,ddtheta_b,'-r','LineWidth',2)
plot(t1+t2+tc,ddtheta_c,'-r','LineWidth',2)
xlabel('time')
ylabel('position, velocity, acceleration')
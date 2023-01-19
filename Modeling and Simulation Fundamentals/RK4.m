% RK4 Demo: Comparing forward Euler to RK4 by measuring the order of convergence

% try lambda = 1, 10, 100
lambda = 100;     % Rate of decay

% define ode, initial condition, and analytical solution
f = @(t,u) -lambda *u;
u0 = 1;
truth = @(t) u0*exp(-lambda*t);

% how long to integrate for
T_final = 1;

% loop through different time-steps and compute error at finally time step
dt_vec = [1e-6, 1e-5, 1e-4, 1e-3, 1e-2, 1e-1];
FEerr = zeros(length(dt_vec),1);
RK4err = zeros(length(dt_vec),1);
for i = 1:length(dt_vec)
    
    % get time step
    dt = dt_vec(i);
    
    % compute forward Euler solution
    [~, u_FE] = forward_euler(f,u0,dt,T_final);
    
    % compute RK4 solution
    [~, u_RK4] = rk4(f,u0,dt,T_final);
    
    % calculate errors relative to the truth
    FEerr(i) = abs(u_FE(end) - truth(T_final));
    RK4err(i) = abs(u_RK4(end) - truth(T_final));
    
end

% plots
figure
loglog(dt_vec,FEerr,'b','linewidth',4)
hold on
loglog(dt_vec,RK4err,'r-.','linewidth',4)
xlabel('dt', 'FontSize',12)
ylabel('Error', 'FontSize',12)
title(['Loglog plots of Error, \lambda = ',num2str(lambda)])
legend('Forward Euler error','RK4 error')

% compute approximate rates
RK4rate =  diff(log10(RK4err));
FErate =   diff(log10(FEerr));

% print table of approximate rates
fprintf(1,'Forward Euler Rates:\t')
fprintf('%s\t', FErate );
fprintf('\n');
fprintf(1,'RK4 Rates:\t\t')
fprintf('%s\t', RK4rate );


% RK4 functions
function u_next = RK4Update(u,t,dt,f)

t_half = t + 0.5*dt;
t_full = t + dt;


k_1 = dt*f(t,u);
u_1 = u + 0.5*k_1;

k_2 = dt*f(t_half,u_1);
u_2 = u + 0.5*k_2;

k_3 = dt*f(t_half,u_2);
u_3 = u + k_3;


k_4 = dt*f(t_full,u_3);

u_next = u + (1/6)*(k_1 + 2*(k_2 + k_3) + k_4);


end


function [t,u] = rk4(f,u0,dt,t_final)
    t = 0:dt:t_final;
    u = [u0, zeros(length(u0),length(t)-1)];
    for i = 1:length(t)-1
        u(:,i+1) = RK4Update(u(:,i),t(i),dt,f);
    end
end

% forward Euler function
function [t,u] = forward_euler(f,u0,dt,t_final)
    t = 0:dt:t_final;
    u = [u0, zeros(length(u0),length(t)-1)];
    for i = 1:length(t)-1
        u(:,i+1) = u(:,i) + dt*f(t(i),u(i));
    end
end


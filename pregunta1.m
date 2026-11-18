clear; clc; close all;
% Datos
A = [0 1; -5 -2];
B = [0; 10];
C = [1 0];
D = 0;

sys = ss(A, B, C, D);
x0 = [-2; 4];
t = (0:0.01:12)';

% Soluciones analiticas
y_renc_a = exp(-t).*(-2*cos(2*t) + sin(2*t));

y_resc_a = 2 - 2*exp(-t).*cos(2*t) ...
    - exp(-t).*sin(2*t);

y_total_a = 2 - 4*exp(-t).*cos(2*t);

% Simulaciones numericas

y_renc_n = initial(sys, x0, t);

y_resc_n = step(sys, t);

u = ones(size(t));
y_total_n = lsim(sys, u, t, x0);

% Grafico RENC
figure(1);
plot(t, y_renc_a, 'b-', 'LineWidth', 2);
hold on;
plot(t, y_renc_n, 'r--', 'LineWidth', 1.5);
grid on;
xlabel('Tiempo (s)');
ylabel('y(t)');
title('Respuesta de Entrada Cero (RENC)');
legend('Analitica', 'MATLAB');
hold off;

% Grafico RESC
figure(2);
plot(t, y_resc_a, 'b-', 'LineWidth', 2);
hold on;
plot(t, y_resc_n, 'r--', 'LineWidth', 1.5);
grid on;
xlabel('Tiempo (s)');
ylabel('y(t)');
title('Respuesta de Estado Cero (RESC)');
legend('Analitica', 'MATLAB');
hold off;

% Grafico respuesta total
figure(3);
plot(t, y_total_a, 'b-', 'LineWidth', 2);
hold on;
plot(t, y_total_n, 'r--', 'LineWidth', 1.5);
grid on;
xlabel('Tiempo (s)');
ylabel('y(t)');
title('Respuesta Total');
legend('Analitica', 'MATLAB');
hold off;

% Verificacion numerica
fprintf('Polos del sistema:\n');
disp(eig(A));

fprintf('Error maximo RENC: %.8e\n', ...
    max(abs(y_renc_a - y_renc_n)));

fprintf('Error maximo RESC: %.8e\n', ...
    max(abs(y_resc_a - y_resc_n)));

fprintf('Error maximo total: %.8e\n', ...
    max(abs(y_total_a - y_total_n)));
% Analisis de estabilidad

polos = eig(A);

if all(real(polos) < 0)
    disp('Sistema asintoticamente estable');
else
    disp('Sistema no asintoticamente estable');
end
% Prueba de fuego

y0 = 2 - 4*exp(0)*cos(0);

dy0 = 4*exp(0)*cos(0) ...
    + 8*exp(0)*sin(0);

fprintf('y(0) = %.2f\n', y0);
fprintf('y''(0) = %.2f\n', dy0);
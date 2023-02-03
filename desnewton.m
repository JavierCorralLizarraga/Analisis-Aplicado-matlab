function [xf, j] = desnewton(fname, x)
%

tol = 1e-05; % tolerancia a la norma del gradiente
jmax = 100; % numero maximo de iteraciones
c1 = 0.1; % parametro para no dar pasos grandes
kmax = 10; % numero maximo de pasos hacia atras

g= gradiente(fname, x); fx = feval(fname, x);
j=0;
while (norm(g) > tol && j < jmax)
    H = hessiana(fname, x); 
    % Sistema lineal H*p = -g
    p = - H\g; % direccion de descenso
    % busqueda de linea
    alfa = 1.0;
    xp = x + alfa * p;
    fxp = feval(fname, xp);
    k=0;
    while( fxp > fx + alfa * ( c1 * g' * p) && k < kmax)
        alfa = alfa / 2;
        xp = x + alfa * p;
        fxp = feval(fname, xp);
        k = k + 1;
    end
    %-------------------------------
    x = x + alfa * p; 
    fx = feval(fname, x);
    g = gradiente(fname, x);
    j = j + 1;
    fprintf('%2.0f %2.8f \n', j, norm(g) )
end

xf = x;

end

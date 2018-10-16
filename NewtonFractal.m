function [out] = NewtonFractal (a,d,n,tol,res,ULcorner,sqrL,zoom)

% CALL THIS FUNCTION DIRECTLY IF YOU WISH TO COMPUTE A STILL IMAGE AND
% UNCOMMENT THE LINE BELOW

%set(0,'DefaultFigureVisible','on')
URcorner=[ULcorner(1)+sqrL,ULcorner(2)];
LLcorner=[ULcorner(1),ULcorner(2)-sqrL];
x=linspace(ULcorner(1),URcorner(1),res);
y=linspace(ULcorner(2),LLcorner(2),res);

[X,Y]=meshgrid(x,y);
Z=X+sqrt(-1).*Y; % THIS IS A MATRIX OF res NUMBER OF POINTS IN THE COMPLEX PLAIN
size_mat=size(Z);
solutions=PolynomialExactSolutions(d); % OBTAIN VECTOR OF ROOTS TO POLYNOMIAL f(x) = x^d - 1
output=zeros(size_mat);
R=zeros(1,n+1);
f=@(x) (x^d)-1;
df=@(x) d*(x^(d-1));

% BEGIN COMPUTATION OF FRACTAL USING NEWTON'S METHOD

    for i=1:size_mat(1)
        for j=1:size_mat(1)
                R(1)=Z(i,j);
                for l=1:n
                    R(l+1)=R(l)-a*(f(R(l))/df(R(l)));
                end
                check=abs(solutions-R(end));

                for k=1:size(solutions,2)  
                    if check(k)<tol
                      output(i,j)=k;
                    end        
                end
        end
    end
    out = output; 
    
    
    
end
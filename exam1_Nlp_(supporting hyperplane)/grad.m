function g = grad(f,x) 
  n = length(x);
  h = 1e-7;
  g = zeros(n,1);
  I = eye(n);
  for i = 1 : n
      g(i) = ( f(x + h * I(:,i)) - f(x - h * I(:,i) ) )/ (2 * h);
  end
end
function circle = build_circle(centre, radius)
%BUILD_CIRCLE 
%Returns 100 equispaced points on the circumference of a circle of the
%passed centre and radius

t = linspace(0, 2*pi);
x = radius * cos(t) + centre(1);
y = radius * sin(t) + centre(2);
circle = [x; y];

end


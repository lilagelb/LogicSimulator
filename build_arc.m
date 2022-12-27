function arc = build_arc(start_pos, end_pos, radius)
%BUILD_ARC 
%Returns an arc of the passed radius, with the passed extreme points
%Note: draws in the anticlockwise direction from start_pos. To flip the
%direction of curvature, swap the order of the passed start and end points

midpoint = 0.5 * (start_pos + end_pos);
start_end = end_pos - start_pos;
distance_start_end = norm(end_pos - start_pos);

% unit direction vector perpendicular to start_end, using cross product
% with unit vector `-k`
centreline_direction = cross([start_end; 0], [0; 0; -1]);
centreline_direction = centreline_direction(1:2) / norm(centreline_direction);

% calculate the distance of the centre of curvature from the midpoint of
% start_end using pythagoras
distance_along_centreline = sqrt(radius^2 - (0.5 * distance_start_end)^2);
% find the centre of curvature
centre = midpoint + distance_along_centreline * centreline_direction;

start_angle = acos( dot(start_pos - centre, [1; 0]) / norm(start_pos - centre) );
end_angle   = acos( dot(end_pos   - centre, [1; 0]) / norm(end_pos   - centre) );

% if the centre is above the point in the y-axis, the angle needs negating,
% as the range of acos is [0, pi], but these angles should be negative to
% be below the centre
if start_pos(2) < centre(2)
    start_angle = -1 * start_angle;
end
if end_pos(2) < centre(2)
    end_angle = -1 * end_angle;
end

% produce the arc's points
t = linspace(min([start_angle, end_angle]), max([start_angle, end_angle]));
x = radius * cos(t) + centre(1);
y = radius * sin(t) + centre(2);

arc = [x; y];

end


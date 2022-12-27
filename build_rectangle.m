function vertexes = build_rectangle(start_point, end_point, width)
%BUILD_RECTANGLE 
%Returns the rectangle symmetrical about the line start_point-end_point,
%with the midpoints of the end sides on start_point and end_point, and a 
%width perpendicular to the line start_point-end_point of that passed

start_end = end_point - start_point;

% make unit vector perpendicular to start_end to find end vertexes
perpendicular = cross([start_end; 0], [0; 0; -1]);
perpendicular = perpendicular(1:2) / norm(perpendicular);

% the start and end point of the rectangle
initial_vertex = start_point - 0.5 * width * perpendicular;

vertexes = [
    initial_vertex, ...
    start_point + 0.5 * width * perpendicular, ...
    end_point   + 0.5 * width * perpendicular, ...
    end_point   - 0.5 * width * perpendicular, ...
    initial_vertex
];
end
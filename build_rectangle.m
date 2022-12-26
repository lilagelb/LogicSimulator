function vertexes = build_rectangle(start_point, end_point, width)
%BUILD_RECTANGLE Returns the rectangle symmetrical about start-end with its
%ends on start and end respectively, with a width perpendicular to
%start-end of that passed

start_end = end_point - start_point;

% make unit vector perpendicular to start_end to find end vertexes
perpendicular = cross([start_end; 0], [0; 0; -1]);
perpendicular = perpendicular(1:2) / norm(perpendicular);

% the start and end point of the rectangle
initial_vertex = start_point - 0.5 * width * perpendicular;

vertexes = [
    initial_vertex, ...
    start_point + 0.5 * width * perpendicular, ...
    end_point + 0.5 * width * perpendicular, ...
    end_point - 0.5 * width * perpendicular, ...
    initial_vertex
]
end
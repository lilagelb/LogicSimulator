function new_coordinates = translate_shape(vertexes, a, b)
%TRANSLATE_SHAPE
%translates the coordinates passed in via vertexes by [a; b]

new_coordinates = vertexes + [a; b];

end


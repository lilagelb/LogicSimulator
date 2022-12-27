function translated_vertices = translate_shape(vertexes, a, b)
%TRANSLATE_SHAPE
%translates the coordinates passed in via vertexes by [a; b], and returns
%the translated vertices

translated_vertices = vertexes + [a; b];

end


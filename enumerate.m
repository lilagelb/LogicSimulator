function enumeration = enumerate(vector)
%ENUMERATE Returns a struct array where element.index is the index of the
%element and element.value is the value from the vector passed in
enumeration = [];
for index = 1:length(vector)
    elem.index = index;
    elem.value = vector(index);
    enumeration = [enumeration, elem];
end
end


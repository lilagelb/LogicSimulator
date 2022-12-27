function enumeration = enumerate(vector)
%ENUMERATE
%Enumerates the passed row or column vector
%Returns a struct array where element.index is the index of the
%element in the vector passed in and element.value is the corresponding
%value

enumeration = [];
for index = 1:length(vector)
    elem.index = index;
    elem.value = vector(index);
    enumeration = [enumeration, elem];
end

end


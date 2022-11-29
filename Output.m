classdef Output < Component
    %OUTPUT Represents an output of the logic circuit

    properties
        output = logical(0);
    end

    methods
        function obj = Output()
            obj.input_pins  = logical([0]);
            obj.output_pins = logical([]);
        end

        function update(obj)
            %UPDATE Updates the output's state
            obj.output = obj.input_pins(1);
        end
    end
end

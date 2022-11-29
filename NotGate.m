classdef NotGate < Component
    %NOTGATE Encapsulates the behaviour of a NOT gate
    
    methods
        function obj = NotGate()
            obj.input_pins  = logical([0]);
            obj.output_pins = logical([0]);
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = ~obj.input_pins(1);
        end
    end
end

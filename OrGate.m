classdef OrGate < Component
    %ORGATE Encapsulates the behaviour of an OR gate
    
    methods
        function obj = OrGate()
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);
        end

        function update(obj)
            %EVALUATE Evaluates the gate's output
            obj.output_pins(1) = obj.input_pins(1) || obj.input_pins(2);
        end
    end
end


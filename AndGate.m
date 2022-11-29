classdef AndGate < Component
    %ANDGATE Encapsulates the behaviour of an AND gate
    
    methods
        function obj = AndGate()
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = obj.input_pins(1) && obj.input_pins(2);
        end
    end
end


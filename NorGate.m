classdef NorGate < LogicGate
    %NORGATE Encapsulates the behaviour of a NOR gate
    
    methods
        function obj = NorGate()
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = ~(obj.input_pins(1) || obj.input_pins(2));
        end
    end
end

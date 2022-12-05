classdef AndGate < Component
    %ANDGATE Encapsulates the behaviour of an AND gate
    
    methods
        function obj = AndGate(position)
            obj@Component(position);
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);
            
            % encode shape
            obj.shape = {[  % base tub
                -3 -3  3  3
                 4  2  2  4
            ], [            % top curve
                build_arc([3; 4], [-3; 4], 3)
            ], [            % input pins
                [-2; 0], [-2; 2]
            ], [
                [2; 0], [2; 2]
            ], [            % output pin
                [0; 7], [0; 9]
            ]};
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = obj.input_pins(1) && obj.input_pins(2);
        end
    end
end


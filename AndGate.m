classdef AndGate < Component
    %ANDGATE Encapsulates the behaviour of an AND gate
    
    methods
        function obj = AndGate(position)
            obj@Component(position);

            % set up pins
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);
            
            % encode shape
            obj.shape = {[  % left tub
                [4; -3], [2; -3], [2; 3], [4; 3]
            ], [            % curve
                build_arc([4; -3], [4; 3], 3)
            ], [            % input pins
                [0; -2], [2; -2]
            ], [
                [0; 2], [2; 2]
            ], [            % output pin
                [7; 0], [9; 0]
            ]};

            % encode pin positions
            obj.input_pin_displacements = [[0; -2], [0; 2]];
            obj.output_pin_displacements = [[9; 0]];
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = obj.input_pins(1) && obj.input_pins(2);
        end
    end
end


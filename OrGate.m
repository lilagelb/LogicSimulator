classdef OrGate < Component
    %ORGATE Encapsulates the behaviour of an OR gate
    
    methods
        function obj = OrGate(position)
            obj@Component(position);
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);

            % encode shape
            obj.shape = {[  % bottom curve
                build_arc([2; -3], [7; 0], 7)
            ], [            % top curve
                build_arc([7; 0], [2; 3], 7)
            ], [            % left curve
                build_arc([2; -3], [2; 3], 6)
            ], [            % input pins
                [0; -2], [2.45; -2]
            ], [
                [0; 2], [2.45; 2]
            ], [            % output pin
                [7; 0], [9; 0]
            ]};

           % encode pin positions
           obj.input_pin_displacements = [[0; -2], [0; 2]];
           obj.output_pin_displacements = [[9; 0]]; 
        end

        function update(obj)
            %EVALUATE Evaluates the gate's output
            obj.output_pins(1) = obj.input_pins(1) || obj.input_pins(2);
        end
    end
end


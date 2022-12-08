classdef NorGate < Component
    %NORGATE Encapsulates the behaviour of a NOR gate
    
    methods
        function obj = NorGate(position)
            obj@Component("nor", position);
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);

            % encode shape
            obj.shape = {[  % bottom curve
                build_arc([2; -3], [8; 0], 7)
            ], [            % top curve
                build_arc([8; 0], [2; 3], 7)
            ], [            % left curve
                build_arc([2; -3], [2; 3], 6)
            ], [            % input pins
                [0; -2], [2.45; -2]
            ], [
                [0; 2], [2.45; 2]
            ], [            % output pin
                [9; 0], [10; 0]
            ], [            % not circle
                build_circle([8.5; 0], 0.5)
            ]};

            % encode pin positions
            obj.input_pin_displacements = [[0; -2], [0; 2]];
            obj.output_pin_displacements = [[10; 0]];
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = ~(obj.input_pins(1) || obj.input_pins(2));
        end
    end
end

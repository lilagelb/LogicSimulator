classdef XnorGate < Component
    %XNORGATE Encapsulates the behaviour of an XNOR gate

    methods
        function obj = XnorGate(position)
            obj@Component("xnor", position);
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);

            % encode shape
            obj.shape = {[  % right curve
                build_arc([2; -3], [8; 0], 7)
            ], [            % left curve
                build_arc([8; 0], [2; 3], 7)
            ], [            % bottom curve (main)
                build_arc([2; -3], [2; 3], 6)
            ], [            % bottom curve (XOR)
                build_arc([1.5; -3], [1.5; 3], 6)
            ], [            % input pins
                [0; -2], [1.95; -2]
            ], [
                [0; 2], [1.95; 2]
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
            obj.output_pins(1) = ~xor(obj.input_pins(1), obj.input_pins(2));
        end
    end
end

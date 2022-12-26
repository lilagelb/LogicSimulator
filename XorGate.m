classdef XorGate < Component
    %XORGATE Encapsulates the behaviour of an XOR gate

    methods
        function obj = XorGate(position)
            obj@Component("xor", position);
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
                [8; 0], [10; 0]
            ]};

            % encode pin positions
            obj.input_pin_displacements = [[0; -2], [0; 2]];
            obj.output_pin_displacements = [[10; 0]]; 

            % encode hitbox (volume enclosed by two large curves and the
            % line between their open ends)
            obj.hitbox = alphaShape([obj.shape{1}, obj.shape{2}]');
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = xor(obj.input_pins(1), obj.input_pins(2));
        end
    end
end

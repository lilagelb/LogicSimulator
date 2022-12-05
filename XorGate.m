classdef XorGate < Component
    %XORGATE Encapsulates the behaviour of an XOR gate

    methods
        function obj = XorGate(position)
            obj@Component(position);
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);

            % encode shape
            obj.shape = {[  % right curve
                build_arc([3; 2], [0; 7], 7)
            ], [            % left curve
                build_arc([0; 7], [-3; 2], 7)
            ], [            % bottom curve (main)
                build_arc([3; 2], [-3; 2], 6)
            ], [            % bottom curve (XOR)
                build_arc([3; 1.5], [-3; 1.5], 6)
            ], [            % input pins
                [-2; 0], [-2; 1.95]
            ], [
                [2; 0], [2; 1.95]
            ], [            % output pin
                [0; 7], [0; 9]
            ]};
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = xor(obj.input_pins(1), obj.input_pins(2));
        end
    end
end

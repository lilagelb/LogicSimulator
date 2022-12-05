classdef NorGate < Component
    %NORGATE Encapsulates the behaviour of a NOR gate
    
    methods
        function obj = NorGate(position)
            obj@Component(position);
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);

            % encode shape
            obj.shape = {[  % right curve
                build_arc([3; 2], [0; 7], 7)
            ], [            % left curve
                build_arc([0; 7], [-3; 2], 7)
            ], [            % bottom curve
                build_arc([3; 2], [-3; 2], 6)
            ], [            % input pins
                [-2; 0], [-2; 2.45]
            ], [
                [2; 0], [2; 2.45]
            ], [            % output pin
                [0; 8], [0; 9]
            ], [            % not circle
                build_circle([0; 7.5], 0.5)
            ]};
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = ~(obj.input_pins(1) || obj.input_pins(2));
        end
    end
end

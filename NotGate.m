classdef NotGate < Component
    %NOTGATE Encapsulates the behaviour of a NOT gate
    
    methods
        function obj = NotGate(position)
            obj@Component(position);
            obj.input_pins  = logical([0]);
            obj.output_pins = logical([0]);

            % encode shape
            obj.shape = {[  % triangle
                [2; -3], [7; 0], [2; 3], [2; -3]
            ], [            % input pin
                [0; 0], [2; 0]
            ], [            % output pin
                [8; 0], [10; 0]
            ], [            % not circle
                build_circle([7.5; 0], 0.5)
            ]};

            % encode pin positions
            obj.input_pin_displacements = [[0; 0]];
            obj.output_pin_displacements = [[10; 0]];
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = ~obj.input_pins(1);
        end
    end
end

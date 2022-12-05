classdef NotGate < Component
    %NOTGATE Encapsulates the behaviour of a NOT gate
    
    methods
        function obj = NotGate(position)
            obj@Component(position);
            obj.input_pins  = logical([0]);
            obj.output_pins = logical([0]);

            % encode shape
            obj.shape = {[  % triangle
                [3; 2], [0; 7], [-3; 2], [3; 2]
            ], [            % input pin
                [0; 0], [0; 2]
            ], [            % output pin
                [0; 8], [0; 9]
            ], [            % not circle
                build_circle([0; 7.5], 0.5)
            ]}
        end

        function update(obj)
            %UPDATE Updates the gate's output
            obj.output_pins(1) = ~obj.input_pins(1);
        end
    end
end

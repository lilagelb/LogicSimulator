classdef OrGate < Component
    %ORGATE
    %Encapsulates the behaviour of an OR gate
    
    methods
        function obj = OrGate(position)
            obj@Component("or", position);

            % initialise pins
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);

            % encode shape
            obj.shape = {[ 
                % bottom curve
                build_arc([2; -3], [8; 0], 7)
            ], [           
                % top curve
                build_arc([8; 0], [2; 3], 7)
            ], [           
                % left curve
                build_arc([2; -3], [2; 3], 6)
            ], [           
                % input pins
                [0; -2], [2.45; -2]
            ], [
                [0; 2], [2.45; 2]
            ], [            
                % output pin
                [8; 0], [10; 0]
            ]};

           % set pin positions
           obj.input_pin_displacements = [[0; -2], [0; 2]];
           obj.output_pin_displacements = [[10; 0]]; 
           
           % encode hitbox (the volume enclosed by the two large curves and 
           % the line between their open ends)
           obj.hitbox = alphaShape([obj.shape{1}, obj.shape{2}]');
        end

        function update(obj)
            %UPDATE
            %Updates the gate's output based on its inputs
            obj.output_pins(1) = obj.input_pins(1) || obj.input_pins(2);
        end
    end
end


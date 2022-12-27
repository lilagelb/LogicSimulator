classdef NandGate < Component
    %NANDGATE
    %Encapsulates the behaviour of a NAND gate
    
    methods        
        function obj = NandGate(position)
            obj@Component("nand", position);

            % initialise pins
            obj.input_pins  = logical([0 0]);
            obj.output_pins = logical([0]);
            
            % encode shape
            obj.shape = {[  
                % left tub
                [5; -3], [2; -3], [2; 3], [5; 3]
            ], [            
                % curve
                build_arc([5; -3], [5; 3], 3)
            ], [            
                % input pins
                [0; -2], [2; -2]
            ], [
                [0; 2], [2; 2]
            ], [            
                % output pin
                [9; 0], [10; 0]
            ], [            
                % negation circle
                build_circle([8.5; 0], 0.5)
            ]};

            % encode pin positions
            obj.input_pin_displacements = [[0; -2], [0; 2]];
            obj.output_pin_displacements = [[10; 0]];
            
            % encode hitbox (the central enclosed volume)
            obj.hitbox = alphaShape([obj.shape{1}, obj.shape{2}]');
        end

        function update(obj)
            %UPDATE
            %Updates the gate's output based on its inputs
            obj.output_pins(1) = ~(obj.input_pins(1) && obj.input_pins(2));
        end
    end
end

classdef Output < Component
    %OUTPUT
    %Encapsulates the behaviour of an output from a logic circuit

    properties
        % initialise internal output state
        output = logical(0);
        label = "";
    end

    methods
        function obj = Output(position, label)
            obj@Component("output", position);
            obj.label = label;

            % initialise pins
            obj.input_pins  = logical([0]);
            obj.output_pins = logical([]);

            % encode shape
            obj.shape = {[  
                % main arrow shape
                [1; -1], [6; -1], [7; 0], [6; 1], [1; 1], [1; -1]
            ], [            
                % input pin
                [0; 0], [1; 0]
            ]};

            % encode pin positions
            obj.input_pin_displacements = [[0; 0]];

            % encode hitbox
            obj.hitbox = alphaShape(obj.shape{1}');
        end

        function update(obj)
            %UPDATE
            %Updates the output's internal output state based on the input
            %state
            obj.output = obj.input_pins(1);
        end
    end
    methods (Access = protected)
        function additional_draw(obj, axes)
            %ADDITIONAL_DRAW
            %Draw the text that displays the output's label
            text(axes, obj.position(1) + 1.5, obj.position(2), obj.label, "Color", "blue");
        end
    end
end

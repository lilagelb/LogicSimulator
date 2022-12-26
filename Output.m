classdef Output < Component
    %OUTPUT Represents an output of the logic circuit

    properties
        output = logical(0);
        label;
    end

    methods
        function obj = Output(position, label)
            obj@Component("output", position);
            obj.label = label;

            % set up pins
            obj.input_pins  = logical([0]);
            obj.output_pins = logical([]);

            % encode shape
            obj.shape = {[  % main arrow shape
                [1; -1], [6; -1], [7; 0], [6; 1], [1; 1], [1; -1]
            ], [            % input pin
                [0; 0], [1; 0]
            ]};

            % encode pin positions
            obj.input_pin_displacements = [[0; 0]];

            % encode hitbox
            obj.hitbox = alphaShape(obj.shape{1}');
        end

        function update(obj)
            %UPDATE Updates the output's state
            obj.output = obj.input_pins(1);
        end
    end
    methods (Access = protected)
        function additional_draw(obj, axes)
            text(axes, obj.position(1) + 1.5, obj.position(2), obj.label, "Color", "blue");
        end
    end
end

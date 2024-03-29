classdef Input < Component
    %INPUT 
    %Encapsulates the behaviour of an input to a logic circuit

    properties
        % initialise internal input state
        input = logical(0);
        label = "";
    end

    methods (Access = public)
        function obj = Input(position, label)
            obj@Component("input", position);
            obj.label = label;

            % initialise pins
            obj.input_pins  = logical([]);
            obj.output_pins = logical([0]);

            % encode shape
            obj.shape = {[
                [0; -1], [5; -1], [6; 0], [5; 1], [0; 1], [0; -1]
            ]};

            % encode pin positions
            obj.output_pin_displacements = [[6; 0]];

            % encode hitbox
            obj.hitbox = alphaShape(obj.shape{1}');
        end

        function update(obj)
            %UPDATE
            %Updates the output's state based on the internal input 
            %state
            obj.output_pins(1) = obj.input;
        end

        function toggle(obj)
            %TOGGLE 
            %Toggles the internal input state
            %Doesn't take external effect until update() is called
            obj.input = ~obj.input;
        end

        function set(obj, level)
            %SET
            %Sets the internal input state
            %Doesn't take external effect until update() is called
            obj.input = logical(level);
        end
    end
    methods (Access = protected)
        function additional_draw(obj, axes)
            %ADDITIONAL_DRAW
            %Draw the text that displays the input's label
            text(axes, obj.position(1) + 0.5, obj.position(2), obj.label, "Color", "blue");
        end
    end
end

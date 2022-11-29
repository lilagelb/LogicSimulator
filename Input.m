classdef Input < Component
    %INPUT Represents an input to the logic circuit

    properties
        input = logical(0);
    end

    methods
        function obj = Input()
            obj.input_pins  = logical([]);
            obj.output_pins = logical([0]);
        end

        function update(obj)
            %UPDATE Updates the output's state
            obj.output_pins(1) = obj.input;
        end

        function toggle(obj)
            %TOGGLE Toggles the internal input state
            %Doesn't take external effect until update() is called
            obj.input = ~obj.input;
        end

        function set(obj, level)
            %SET Sets the internal input state
            %Doesn't take external effect until update() is called
            obj.input = logical(level);
        end
    end
end

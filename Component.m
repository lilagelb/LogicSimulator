classdef Component < handle
    %Component Base class for components
    properties (Access = protected)
        % 1 x n row vectors representing the state of each pin
        input_pins;
        output_pins;

        % 2x1 column vector at the centre of the icon
        position;
        
        % 2 x n matrices holding the x and y displacements of the input and
        % output pin positions from the central position
        input_pin_displacements;
        output_pin_displacements;
        
        % the points to draw as continuous lines to produce the component
        % icon
        % to be overridden by implementations of this class
        % this draws a box with an 'x' in it
        shape = {[
            -0.5 0.5  0.5 -0.5 -0.5;
             0.5 0.5 -0.5 -0.5  0.5;
        ], [
             0.5 -0.5;
            -0.5  0.5;
        ], [
            -0.5 0.5;
            -0.5 0.5;
        ]};
    end

    methods (Access = protected)
        function obj = Component(position)
            %COMPONENT Construct an instance of this class
            obj.position = position;
        end

        function additional_draw(obj)
            %ADDITIONAL_DRAW For overriding by components that require more
            %than a simple shape (e.g. text) to be drawn for their symbol
        end
    end
    methods (Access = public)
        function output = update(obj)
            %EVALUATE Updates the symbols's output for its inputs
            output = false;
        end

        function draw(obj)
            %DRAW Draws the component's symbol with its centre at its
            %position
            num_lines = length(obj.shape);
            for i = 1:num_lines
                line = translate_shape(obj.shape{i}, obj.position(1), obj.position(2));
                plot(line(1, :), line(2, :), "b");
                hold on;
            end
            obj.additional_draw();
            hold off;
        end

        function pos = get_input_pin_position(obj, pin_number)
            %GET_INPUT_PIN_POSITION Returns the position of the specified
            %input pin on the plot, to allow lines to be drawn to/from it
            pos = obj.position + obj.input_pin_displacements(:, pin_number);
        end
        function pos = get_output_pin_position(obj, pin_number)
            %GET_OUTPUT_PIN_POSITION Returns the position of the specified
            %output pin on the plot, to allow lines to be drawn to/from it
            pos = obj.position + obj.output_pin_displacements(:, pin_number);
        end
    end
end

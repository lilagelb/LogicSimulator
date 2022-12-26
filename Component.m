classdef Component < handle
    %Component Base class for components
    properties (Access = public)
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

        % the hitbox of the component, for selection purposes
        % defined as an alphaShape
        hitbox = alphaShape;

        % printable type (for serialisation)
        type_printable = "component"
    end

    methods (Access = protected)
        function obj = Component(type_printable, position)
            %COMPONENT Construct an instance of this class
            obj.type_printable = type_printable;
            obj.position = position;
        end

        function additional_draw(obj, axes)
            %ADDITIONAL_DRAW For overriding by components that require more
            %than a simple shape (e.g. text) to be drawn for their symbol
        end
    end
    methods (Access = public)
        function output = update(obj)
            %EVALUATE Updates the symbols's output for its inputs
            output = false;
        end

        function draw(obj, axes, linespec)
            %DRAW Draws the component's symbol with its centre at its
            %position
            num_lines = length(obj.shape);
            for i = 1:num_lines
                line = translate_shape(obj.shape{i}, obj.position(1), obj.position(2));
                plot(axes, line(1, :), line(2, :), linespec);
                hold(axes, "on");
            end
            obj.additional_draw(axes);
            hold(axes, "off");
        end

        function set_input_pin(obj, pin, state)
            %SET_INPUT_PIN Sets the given input pin to the given state 
            % (either `logical(0)` or `logical(1)`)
            obj.input_pins(pin) = state;
        end
        function state = get_output_pin(obj, pin)
            %GET_OUTPUT_PIN Returns the state of the given output pin
            %(either `logical(0)` or `logical(1)`)
            state = obj.output_pins(pin);
        end
        function position = get_position(obj)
            %GET_POSITION Returns the position of the component
            position = obj.position;
        end
        function type_printable = get_type_printable(obj)
            %GET_TYPE_PRINTABLE Returns the printable form of the
            %component's type (e.g. 'and' for an AND gate)
            type_printable = obj.type_printable;
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

        function [pin, input] = get_pin_from_position(obj, position)
            %GET_PIN_FROM_POSITION If the passed position is the end of one
            %of the component's pins, return that pin, otherwise 0.
            %If the pin is an input pin, input=true, otherwise input=false
            input = false;
            pin = 0;
            for n = 1:length(obj.input_pins)
                if obj.get_input_pin_position(n) == position
                    pin = n;
                    input = true;
                    return;
                end
            end
            for n = 1:length(obj.output_pins)
                if obj.get_output_pin_position(n) == position
                    pin = n;
                    return;
                end
            end
        end

        function is_contained = contains_point(obj, point)
            %CONTAINS_POINT Returns whether the passed point is within the
            %component's hitbox
            
            % transform the point to the object's origin, since it is about
            % this that the hitbox is defined
            point = point - obj.position;

            if inShape(obj.hitbox, point(1), point(2))
                is_contained = true;
                return;
            end
            
            is_contained = false;
        end
    end
end

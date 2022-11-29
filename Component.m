classdef Component < handle
    %Component Base class for components
    properties
        % 1 x n row vectors representing the state of each pin
        input_pins;
        output_pins;

        % 2x1 column vector at the centre of the icon
        position;
        
        % 2 x n matrices holding the x and y displacements of the input and
        % output pin positions from the central position
        input_pin_displacements;
        output_pin_displacements;
        
        % the points to draw as a continuous line to produce the component
        % icon
        % to be overridden by implementations of this class
        % this draws a box with an 'x' in it
        shape = [
            -0.5 0.5  0.5 -0.5 -0.5  0.5 -0.5 0.5;
             0.5 0.5 -0.5 -0.5  0.5 -0.5 -0.5 0.5;
        ];
    end

    methods (Access = protected)
        function obj = Component()
            %LOGICGATE Construct an instance of this class
        end
    end
    methods (Access = public)
        function output = update(obj)
            %EVALUATE Updates the gate's output for its inputs
            output = false;
        end
    end
end

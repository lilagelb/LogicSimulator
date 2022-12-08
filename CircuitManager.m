classdef CircuitManager < handle
    %CIRCUITMANAGER Manages the circuit as a whole
    %Responsable for tracking links between components and updating the
    %circuit state

    properties
        % links are stored as a struct array
        links = [];
        
        % components are stored as a cell array
        components = [];
        next_component_id = 1;
    end

    methods
        function obj = CircuitManager()
        end

        function component_id = add_component(obj, component)
            %ADD_COMPONENT Adds a component to the circuit and returns the
            %ID that will henceforth be used to identify it
            obj.components = [obj.components, {component}];
            component_id = obj.next_component_id;
            obj.next_component_id = obj.next_component_id + 1;
        end

        function add_link(obj, from_component, from_pin, to_component, to_pin)
            %ADD_LINK Adds an electrical connection between an output pin
            %of one component and an input pin of another
            new_link.from_component = from_component;
            new_link.from_pin = from_pin;
            new_link.to_component = to_component;
            new_link.to_pin = to_pin;
            obj.links = [obj.links, new_link];
        end

        function [component, pin, input] = get_component_and_pin_from_position(obj, position)
            %GET_COMPONENT_AND_PIN_FROM_POSITION Returns the component and
            %pin number that occupies a position, as well as whether that
            %pin is an input or an output
            %If no pin occupies the position, returns [0, 0, false]
            for n = 1:length(obj.components)
                [pin, input] = obj.components{n}.get_pin_from_position(position);
                if pin ~= 0
                    component = n;
                    return
                end
            end
            component = 0;
            pin = 0;
            input = false;
        end

        function update(obj)
            for id = 1:length(obj.components)
                % update the component
                obj.components{id}.update();

                % update the component's links
                for link = obj.links
                    if link.from_component == id
                        obj.components{link.to_component} ...
                            .input_pins(link.to_pin) ...
                          = ...
                            obj.components{link.from_component} ...
                                .output_pins(link.from_pin);
                    end
                end
            end
        end

        function draw(obj, axes)
            %DRAW Draws the logic circuit, with the components in blue and
            %links in red
            for id = 1:length(obj.components)
                obj.components{id}.draw(axes);
                hold(axes, "on");
            end
            for link = obj.links
                start_pos = obj.components{link.from_component}.get_output_pin_position(link.from_pin);
                end_pos = obj.components{link.to_component}.get_input_pin_position(link.to_pin);
                plot(axes, [start_pos(1), end_pos(1)], [start_pos(2), end_pos(2)], "r");
            end
            hold(axes, "off");
        end
    end

end
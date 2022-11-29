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
    end

end
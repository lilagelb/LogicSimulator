classdef CircuitManager < handle
    %CIRCUITMANAGER 
    %Encapsulates a logic circuit
    %Responsible for tracking links between components and evaluating the
    %circuit state

    properties
        % links are stored as a struct array as below:
        % link:
        %   from_component: the ID of the component the link is from
        %   from_pin:       the ID of the output pin the link is from
        %   to_component:   the ID of the component the link is to
        %   to_pin:         the ID of the output pin the link is to
        %   hitbox:         an alphaShape describing the hitbox of the link for selection purposes
        links = [];
        
        % components are stored as a cell array of Components
        components = [];
    end

    methods
        function obj = CircuitManager()
        end

        function component_id = add_component(obj, component)
            %ADD_COMPONENT
            %Adds a component to the circuit and returns the ID that will
            %henceforth be used to identify it

            obj.components = [obj.components, {component}];
            component_id = length(obj.components);
        end

        function add_link(obj, from_component, from_pin, to_component, to_pin)
            %ADD_LINK 
            %Adds an electrical connection between an output pin of one
            %component and an input pin of another

            new_link.from_component = from_component;
            new_link.from_pin = from_pin;
            new_link.to_component = to_component;
            new_link.to_pin = to_pin;
            new_link.hitbox = alphaShape(build_rectangle( ...
                obj.components{from_component}.get_output_pin_position(from_pin), ...
                obj.components{to_component}.get_input_pin_position(to_pin), ...
                2 ...
            )');
            obj.links = [obj.links, new_link];
        end

        function remove_component(obj, component_id)
            %REMOVE_COMPONENT
            %Removes the component identified by the passed ID from the
            %circuit, and deletes any links to the component

            % remove the component from the component cell array
            obj.components(component_id) = [];

            % renumber the links to reflect the new component IDs, and
            % delete any that actually go to the now-deleted component
            for index = length(obj.links):-1:1
                link = obj.links(index);
                
                if link.from_component == component_id || link.to_component == component_id                        
                    obj.remove_link(index);
                    continue;
                end

                obj.links(index).from_component ...
                    = adjust_link_value_if_necessary(link.from_component, component_id);
                obj.links(index).to_component ...
                    = adjust_link_value_if_necessary(link.to_component, component_id);
            end
        end

        function remove_link(obj, link_id)
            %REMOVE_LINK 
            %Removes the link identified by the passed ID from the circuit
            obj.links(link_id) = [];
        end

        function [component, pin, input] = get_component_and_pin_from_position(obj, position)
            %GET_COMPONENT_AND_PIN_FROM_POSITION
            %Returns the component and pin number that occupies a position,
            %as well as whether that pin is an input or an output.
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
            %UPDATE
            %Updates the state of each component in turn based on the state
            %of the circuit, updating the links from the component's
            %output(s) afterwards

            for id = 1:length(obj.components)
                % update the component
                obj.components{id}.update();

                % update the component's links
                for link = obj.links
                    if link.from_component == id
                        obj.components{link.to_component}.set_input_pin( ...
                            link.to_pin, ...
                            obj.components{link.from_component}.get_output_pin(link.from_pin) ...
                        );
                    end
                end
            end
        end

        function draw(obj, axes)
            %DRAW
            %Draws the logic circuit on the passed axes, with the 
            %components in blue and links in red

            for id = 1:length(obj.components)
                obj.components{id}.draw(axes, "b");
                hold(axes, "on");
            end
            for link = obj.links
                obj.draw_link(axes, link, "r");
            end
            hold(axes, "off");
        end

        function draw_link(obj, axes, link, linespec)
            %DRAW_LINK
            %Draws the link with the passed ID on the given axes using the
            %passed LineSpec

            start_pos = obj.components{link.from_component}.get_output_pin_position(link.from_pin);
            end_pos = obj.components{link.to_component}.get_input_pin_position(link.to_pin);
            plot(axes, [start_pos(1), end_pos(1)], [start_pos(2), end_pos(2)], linespec);
        end

        function [type, id] = get_type_and_id_of_clicked_object(obj, position)
            %GET_TYPE_AND_ID_OF_CLICKED_OBJECT
            %Checks if the click position aligns with a circuit object. 
            %If it does, returns the object's type ("component" or "link") 
            %and its ID (positive integer). Else, returns ["", 0]
            
            % check if the click aligns with a component
            for index = 1:length(obj.components)
                if obj.components{index}.contains_point(position)
                    % the click aligned with this component, so return
                    type = "component";
                    id = index;
                    return;
                end
            end
                    
            % check if the click aligns with a link
            for link = enumerate(obj.links)
                if inShape(link.value.hitbox, position(1), position(2))
                    % the click aligned with this link, so return
                    type = "link";
                    id = link.index;
                    return;
                end
            end
            
            % the click aligned with nothing, so return the default values
            type = "";
            id = 0;
        end

        function serialise(obj, filepath)
            %SERIALISE 
            %Serialises the class data into an LSIM file (YAML-based) for
            %storage, using the filepath specified

            % add the metadata header
            serialisation = sprintf( ...
                "component-count: %d\n" + ...
                "link-count: %d\n", ...
                length(obj.components), length(obj.links) ...
            );

            % serialise the components
            serialisation = serialisation + "\ncomponents:\n";
            for component_index = 1:length(obj.components)
                component = obj.components{component_index};
                type = component.get_type_printable();
                position = component.get_position();

                serialisation = serialisation + sprintf( ...
                    "- component:\n" + ...
                    "    type: %s\n" + ...
                    "    position: [%d, %d]\n", ...
                    type, ...
                    position(1), position(2) ...
                );

                if type == "input" || type == "output"
                    serialisation = serialisation + sprintf( ...
                        "    label: %s\n", ...
                        component.label ...
                    );
                end
            end
            
            % serialise the links
            serialisation = serialisation + "\nlinks:\n";
            for link = obj.links
                serialisation = serialisation + sprintf( ...
                    "- link:\n" + ...
                    "  - from:\n" + ...
                    "      component: %d\n" + ...
                    "      pin: %d\n" + ...
                    "  - to:\n" + ...
                    "      component: %d\n" + ...
                    "      pin: %d\n", ...
                    link.from_component, link.from_pin, ...
                    link.to_component, link.to_pin ...
                );
            end

            % write the serialisation to the file specified
            filehandle = fopen(filepath, "w");
            fprintf(filehandle, serialisation);
            fclose(filehandle);
        end

        function deserialise(obj, filepath)
            %DESERIALISE
            %Deserialises the data from the filepath given and loads it
            %into the class, overwriting existing data

            % open the file
            filehandle = fopen(filepath, "r");

            % clear existing data
            obj.components = [];
            obj.links = [];

            % read and process the header
            component_count = fscanf(filehandle, "component-count: %d\n", 1);
            link_count = fscanf(filehandle, "link-count: %d\n", 1);
            
            % read in the components
            fscanf(filehandle, "\ncomponents:\n", 1);
            for n = 1:component_count
                type = fscanf(filehandle, ...
                    "- component:\n" + ...
                    "    type: %s\n", 1);
                position = fscanf(filehandle, "    position: [%d, %d]\n", 2);
                if type == "input" || type == "output"
                    label = fscanf(filehandle, "    label: %s\n", 1);
                    if type == "input"
                        obj.add_component(Input(position, label));
                    else
                        obj.add_component(Output(position, label));
                    end
                elseif type == "not"
                    obj.add_component(NotGate(position));
                elseif type == "and"
                    obj.add_component(AndGate(position));
                elseif type == "or"
                    obj.add_component(OrGate(position));
                elseif type == "xor"
                    obj.add_component(XorGate(position));
                elseif type == "nand"
                    obj.add_component(NandGate(position));
                elseif type == "nor"
                    obj.add_component(NorGate(position));
                elseif type == "xnor"
                    obj.add_component(XnorGate(position));
                end
            end

            % read in the links
            fscanf(filehandle, "\nlinks:\n", 1);
            for n = 1:link_count
                from_component = fscanf(filehandle, ...
                    "- link:\n" + ...
                    "  - from:\n" + ...
                    "      component: %d\n", 1);
                from_pin = fscanf(filehandle, "      pin: %d\n", 1);
                to_component = fscanf(filehandle, ...
                    "  - to:\n" + ...
                    "      component: %d\n", 1);
                to_pin = fscanf(filehandle, "      pin: %d\n", 1);
                obj.add_link(from_component, from_pin, to_component, to_pin);
            end

            % close the file
            fclose(filehandle);
        end
    end
end


function new_value = adjust_link_value_if_necessary(current_value, threshold)
    %ADJUST_LINK_VALUE_IF_NECESSARY
    %Checks if current_value is above the threshold, and if it is, return
    %current_value - 1.
    %Used for updating links in the event a component is deleted
    
    if current_value > threshold
        new_value = current_value - 1;
    else
        new_value = current_value;
    end
end
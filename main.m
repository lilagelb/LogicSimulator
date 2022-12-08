circuit = CircuitManager;

input_0 = circuit.add_component(Input([0; -3], "in 0"));
input_1 = circuit.add_component(Input([0; 3], "in 1"));
xor_gate = circuit.add_component(XorGate([15; -5]));
and_gate = circuit.add_component(AndGate([15; 5]));
output_0 = circuit.add_component(Output([30; -3], "out 0"));
output_1 = circuit.add_component(Output([30; 3], "out 1"));

circuit.add_link(input_0, 1, xor_gate, 1);
circuit.add_link(input_0, 1, and_gate, 1);
circuit.add_link(input_1, 1, xor_gate, 2);
circuit.add_link(input_1, 1, and_gate, 2);
circuit.add_link(xor_gate, 1, output_0, 1);
circuit.add_link(and_gate, 1, output_1, 1);

a = axes(ButtonDownFcn=@callback);
a.Interactions = [panInteraction, rulerPanInteraction, zoomInteraction];
circuit.draw(a);

axis padded;
axis equal;
grid on;

function callback(src, event)
    src
    hold on;
    plot(src, event.IntersectionPoint(1), event.IntersctionPoint(2), "kx");
end
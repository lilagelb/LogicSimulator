circuit = CircuitManager();
not_gate = circuit.add_component(NotGate([0; 0]));

circuit.components{not_gate}.draw();


axis([-5 5 -0 10]);
axis square;
grid on;
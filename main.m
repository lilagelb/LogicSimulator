circuit = CircuitManager();
circuit.add_component(XorGate([0; 0]));

circuit.draw();


axis([0 10 -5 5]);
axis square;
grid on;
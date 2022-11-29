circuit = CircuitManager();

input_1 = circuit.add_component(Input);
input_2 = circuit.add_component(Input);
output_1 = circuit.add_component(Output);
output_2 = circuit.add_component(Output);
and_gate = circuit.add_component(AndGate);
xor_gate = circuit.add_component(XorGate);


circuit.add_link(input_1, 1, xor_gate, 1);
circuit.add_link(input_2, 1, xor_gate, 2);
circuit.add_link(xor_gate, 1, output_2, 1);
circuit.add_link(input_1, 1, and_gate, 1);
circuit.add_link(input_2, 1, and_gate, 2);
circuit.add_link(and_gate, 1, output_1, 1);


for i1 = 0:1
    for i2 = 0:1
        circuit.components{input_1}.set(i1);
        circuit.components{input_2}.set(i2);

        for n = 1:2
            circuit.update();
        end

        o1 = circuit.components{output_1}.output;
        o2 = circuit.components{output_2}.output;

        fprintf("%d + %d = %d%d\n", i1, i2, o1, o2);
    end
end

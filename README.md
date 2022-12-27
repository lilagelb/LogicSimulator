# LogicSimulator
A basic GUI-based logic circuit simulator for steady-state logic circuit creation, manipulation, and evaluation using the following components:
- NOT, AND, OR, XOR, NAND, NOR, XNOR gates
- 1-pin input
- 1-pin output

> Note: it is currently the case that if a point that is part of a line on the circuit diagram is clicked, the click callback won't fire and the click won't be processed. It is necessary to take advantage of the grid snapping and click near to the desired point instead


# The LSIM File Format
LogicSimulator files use the `.lsim` file extension, and are plaintext [YAML](https://en.wikipedia.org/wiki/YAML) that follows the format below (using the [half adder](circuits/half_adder.lsim) as an example). The file is split into 3 sections, each separated by a single blank line.

It is not recommended to edit LSIM files directly, as without care it is easy to cause problems. Nonetheless, the format aims to be open and easy to interpret.

### Header
The file starts with a metadata header:
```yaml
component-count: 6
link-count: 6
```
This tells the file parser how many components and links to expect.

### Components
The components section is a list. Each component has either two or three attributes (every component has a `type` and a `position`, but `input`- and `output`-type components also have a `label`):
```yaml
components:
- component:
    type: input
    position: [20, 20]
    label: in1
- component:
    type: input
    position: [20, -20]
    label: in2
- component:
    type: and
    position: [50, 10]
- component:
    type: xor
    position: [50, -10]
- component:
    type: output
    position: [80, 10]
    label: out1
- component:
    type: output
    position: [80, -10]
    label: out2
```

### Links
The links section is similar to the components section, in that each link is a seperate entry in a list. Each link is itself a two-element list, detailing the `to` and `from` of the link. Links store their links using component and pin IDs. These IDs are merely the respective indices in the component, input pin, and output pin vectors when the file is loaded. The file is loaded sequentially, so the first component in the components section will have ID 1, the next will have ID 2, and so on. Thus, it is possible to divine the component IDs by examining the file.
```yaml
- link:
  - from:
      component: 1
      pin: 1
  - to:
      component: 3
      pin: 2
- link:
  - from:
      component: 1
      pin: 1
  - to:
      component: 4
      pin: 2
- link:
  - from:
      component: 2
      pin: 1
  - to:
      component: 3
      pin: 1
- link:
  - from:
      component: 2
      pin: 1
  - to:
      component: 4
      pin: 1
- link:
  - from:
      component: 3
      pin: 1
  - to:
      component: 5
      pin: 1
- link:
  - from:
      component: 4
      pin: 1
  - to:
      component: 6
      pin: 1
```

# LogicSimulator
A basic GUI-based logic circuit simulator for steady-state logic circuit creation, manipulation, and evaluation using the following components:
- NOT, AND, OR, XOR, NAND, NOR, XNOR gates
- 1-pin input
- 1-pin output

> Note: the software doesn't currently warn the user before overwriting unsaved data. Take care when creating new files and opening existing files.

# Using LogicSimulator
## Creating Circuits
When LogicSimulator opens, it will have a blank canvas. If you've already done something, but want to start again, you can use 'File > New' from the menu bar to clear the canvas. **Make sure you save your previous work first if you want to keep it!**

To add components, select the 'Place' mode, then select the desired component from the list. Click anywhere on the canvas to place the component there. To add links between components, select the 'Place' mode, and select 'Link' from the component selection. Click once at the start of the link (this will be indicated by a red star after you've clicked), then again at the end point of the link.

> Note: it is currently the case that if a point that is part of a line on the circuit diagram is clicked, the click callback won't fire and the click won't be processed. It is necessary to take advantage of the grid snapping and click near to the desired point instead

To edit components, select the 'Select' mode, then click on the component you wish to edit (note that, due to the above reason, when selecting links, you must click *next to* the link, not *on* the link). The component will turn green once selected. You can then use the Action buttons to delete the component, or, if it's not a link, move the component. To move a component, click 'Move', then select the new desired position. Logic gates will also display their truth tables when selected.

## Evaluating Circuits
To evaluate a circuit, click the 'Reevaluate' button on the right-hand side. The truth table for the whole circuit will then be displayed on the right-hand side.

## Saving/Loading Circuits
LogicSimulator allows for saving and loading circuits through the YAML-based LSIM format (see below).

To save a file, go to 'File > Save' or 'File > Save As'. To open an existing file, go to 'File > Open', then select the desired file from the dialog. There are some examples in the [circuits directory](circuits/). **Make sure you save your currently open work first if you want to keep it!**

---

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

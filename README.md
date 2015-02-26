# Iridium
Iridium is a decomposition framework for usage with the x86 family of Assembly
languages. It was designed to be easy-to use, effective and extensible. It is
divided into three modules, which maintain different parts of analysis.

## Features
* Analysis of control flow, using structural analysis.
  + Supports all HLL-constructs except `goto`, `break`, `continue`, altough support
    for them should be added in the future.
  + Analyzes complex conditions found in the code.
  + Presents the results in an easy-to-understand format.
* Analysis of data found on the stack.
  + Applies a heuristic to determine which data is a varable, which size it has and
    whether it is a pointer.
* Analysis of optimized integer divisions.
  + Recovery of divisor from the source.
  + Interactive mode.
* A separation between the modules, which makes it easy to implement new input
  methods and integrate Iridium into already existing projects.

## Installation and usage
To be written.

## Extending
To be written.

## TODO
To be written.


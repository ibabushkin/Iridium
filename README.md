# Iridium
Iridium is a decomposition framework for usage with the x86 family of Assembly
languages. It was designed to be easy-to use, effective and extensible. It is
divided into three modules, which maintain different parts of analysis.
Written completely in Python, it is intended for Reverse Engineers and Malware
Analysts who want to perform certain aspects of static analysis in an automated
fashion without "losing touch" with the binary's code.

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
Iridium is written completely in Python. To use it, just make sure it is on your
`PYTHONPATH`. The concept I followed while developing it was to make sure the code
performing analysis is strictly separated from the code that parses the user's input
etc. At the moment, only one way of feeding data to Iridium is present, but that is
to be changed in the near future.

To make use of all the features, `cd` into the project's root and run
`python IDAIridium.py <file>`, where file is an Assembly listing generated by IDA Pro.
This will split the code into functions and analyze them seperately, saving the results
on disk. If you already have a `.asm`-file that contains only one function, you can
simply run one of the modules as a script, providing the file as an argument. The modules
are the same as used by `IDAIridium.py` and are stored in the `defines`-tree. For more
information, see their documentation by running `python <module> -h`.

## Extending
To write modules that accept other kinds of input than just `.asm`-files generated by
IDA Pro, I recommend following the structure of `IDAIridium.py`. More information etc.
is likely to follow, since I plan to write other input-parsing-modules as well.

## TODO
To be written.


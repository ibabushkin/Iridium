# settings.py - global settings regarding file layout and naming rules,
# quite rudimental

# append the given string to the name of the file
RESULTS_DIR_NAME_SUFFIX = "_analysis"
# being analyzed to generate the directory name
SKIP_FILE_EXTENSION_FOR_DIRNAME = True
# data.asm --> 'data_analysis', not 'data.asm_analysis'

FILENAME_EXTENSIONS = {'cfg': '.cfg', 'data': '.data', 'div': '.div'}
# to circumvent the bulky names currently used, everyone can modify this.

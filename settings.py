# settings.py - global settings regarding file layout and naming rules, quite rudimental

RESULTS_DIR_NAME = "_analysis" # append the given string to the name of the file
                                # being analyzed to generate the directory name
SKIP_FILE_EXTENSION_FOR_DIRNAME = True 
                                # data.asm --> 'data.analysis', not 'data.asm_analysis'

FILENAME_EXTENSIONS = {'cfg':'.cfg', 'data':'.data', 'div':'.div'}
                                # to circumvent the bulky names currently used


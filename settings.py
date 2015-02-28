"""
File: settings.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: None

Description:
    Holds all user-customizable values that affect
    the working of the frontends (currently only Iridium_IDA.py).

Attributes:
    RESULTS_DIR_NAME_SUFFIX (str): A string to add to the name of the
        file to be analyzed. Defaults to "_analysis".

    SKIP_FILE_EXTENSION_FOR_DIRNAME (bool): When generating the dirname
        for analysis, use the full filename or skip the extension?
        Defaults to True.

    FILENAME_EXTENSIONS (dict): Maps a str-value to every key in 'cfg',
        'data', 'div'. This value is used as a filename extension for
        analysis results of the corresponding module.
        Includes the dot.
"""
RESULTS_DIR_NAME_SUFFIX = "_analysis"
SKIP_FILE_EXTENSION_FOR_DIRNAME = True
FILENAME_EXTENSIONS = {'cfg': '.cfg', 'data': '.data', 'div': '.div'}


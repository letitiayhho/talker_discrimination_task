#!/usr/bin/env python3

import os
import glob
import pandas as pd
os.chdir("/Users/letitiaho/src/speeded_target_recognition_data_processing")

extension = 'csv'
all_filenames = [i for i in glob.glob('../speeded_target_recognition_task/task/output/*.csv')]
print(all_filenames)

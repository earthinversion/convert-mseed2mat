import scipy.io as sio
from obspy import read
import os, sys
import argparse


mseedfile = 'example_2020-05-01_IN.RAGD..BHZ.mseed'

info_string = '''
Python utility program to convert mseed file to mat (by Utpal Kumar, IESAS, 2021/04)
'''

PARSER = argparse.ArgumentParser(description=info_string)

def main(args):
    mseedfile = args.input_mseed
    st = read(mseedfile)

    filename, _ = os.path.splitext(mseedfile)
    if not args.output_mat:
        outfilename = filename +".mat"
    else:
        outfilename = args.output_mat

    outdict = {}


    st.plot(outfile=f"{filename}.png")
    for ii,tr in enumerate(st):
        outdict[f'stats_{ii}'] = {}
        for val in tr.stats:
            if val in ['starttime', 'endtime']:
                outdict[f'stats_{ii}'][val] = str(tr.stats[val])
            else:
                outdict[f'stats_{ii}'][val] = tr.stats[val]
        outdict[f"data_{ii}"] = tr.data
        
    # print(outdict)
    sio.savemat(
        outfilename, outdict
    )
    sys.stdout.write(f"Output file: {outfilename}\n")

if __name__ == '__main__':
    PARSER.add_argument("-inp",'--input_mseed', type=str, help="input mseed file, e.g. example_2020-05-01_IN.RAGD..BHZ.mseed", required=True)
    PARSER.add_argument("-out",'--output_mat', type=str, help="output mat file name, e.g. example_2020-05-01_IN.RAGD..BHZ.mat")
    

    args = PARSER.parse_args()
    main(args)
import argparse
import matplotlib.pyplot as plt
import os


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--file', required=True)
    args = parser.parse_args()
    rss_arr = []
    vsz_arr = []
    with open(args.file) as fin:
        for l in fin:
            if "UID" in l or "Linux" in l:
                continue
            l = l.strip()
            if l == "":
                continue
            sp = l.split()
            rss = float(sp[-3]) / 1024
            vsz = float(sp[-4]) / 1024
            rss_arr.append(rss)
            vsz_arr.append(vsz)
    fname = os.path.basename(args.file)
    stem = os.path.splitext(fname)[0]
    # data is collected per second
    rss_t = [i for i in range(len(rss_arr))]
    vsz_t = [i for i in range(len(vsz_arr))]
    plt.figure()
    plt.plot(rss_t, rss_arr, label="RSS(MB)")
    plt.plot(vsz_t, vsz_arr, label="VSZ(MB)")
    plt.xlabel('time(s)')
    plt.ylabel('memory(MB)')
    plt.legend()
    # plt.show()
    plt.savefig(f'./{stem}_mem.pdf', bbox_inches='tight')


if __name__ == '__main__':
    main()

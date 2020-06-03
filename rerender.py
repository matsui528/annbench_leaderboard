# Just to rerender an image from yaml file
# $ python rerender.py
# $ python rerender.py --help     # To check args


import yaml
import fire
from pathlib import Path

import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt

# The following visualization function is from:
# https://github.com/matsui528/annbench/blob/master/annbench/vis.py
def draw(lines, xlabel, ylabel, title, filename, with_ctrl, width, height):
    """
    Visualize search results and save them as an image
    Args:
        lines (list): search results. list of dict.
        xlabel (str): label of x-axis, usually "recall"
        ylabel (str): label of y-axis, usually "query per sec"
        title (str): title of the result_img
        filename (str): output file name of image
        with_ctrl (bool): show control parameters or not
        width (int): width of the figure
        height (int): height of the figure
    """
    plt.figure(figsize=(width, height))

    for line in lines:
        for key in ["xs", "ys", "label", "ctrls", "ctrl_label"]:
            assert key in line

    for line in lines:
        plt.plot(line["xs"], line["ys"], 'o-', label=line["label"])
        if with_ctrl:
            for x, y, ctrl in zip(line["xs"], line["ys"], line["ctrls"]):
                plt.annotate(s=line["ctrl_label"] + ":" + str(ctrl), xy=(x, y),
                             xytext=(x, y+50))

    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.grid(which="both")
    plt.yscale("log")
    plt.legend()
    plt.title(title)
    plt.savefig(filename)
    plt.cla()


def run(input_yaml="result_img/2020_03_14/siftsmall.yaml", output_img="out.png",
        title="siftsmall", with_query_param=True, width=10, height=8):
    # out.png should be same as "result_img/2020_03_14/siftsmall.png"
    print(input_yaml, output_img)
    with Path(input_yaml).open("rt") as f:
        lines = yaml.safe_load(f)
    draw(lines=lines, xlabel="recall@1", ylabel="query/sec (1/s)", title=title,
         filename=output_img, with_ctrl=with_query_param, width=width, height=height)


if __name__ == '__main__':
    fire.Fire(run)

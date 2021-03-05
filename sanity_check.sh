# Should be run at "./annbench"

echo "## Sanity check for annoy" >> ../report.md
rm -rf output
python run.py algo=annoy dataset=siftsmall "algo.param_index=\
[\
    {n_trees:100},\
    {n_trees:200},\
    {n_trees:400},\
    {n_trees:800},\
    {n_trees:1600}\
]"
python plot.py
cml-publish ./result_img/siftsmall.png --md >> ../report.md

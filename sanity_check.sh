# Should be run at "./annbench"

echo "## Sanity check for annoy" >> ../report.md
rm -rf output
python run.py algo=annoy dataset=siftsmall "algo.param_index=\
[\
    {n_trees: 100},\
    {n_trees: 200},\
    {n_trees: 400},\
    {n_trees: 800},\
    {n_trees: 1600}\
]"
python plot.py
cml-publish ./result_img/siftsmall.png --md >> ../report.md


echo "## Sanity check for hnsw" >> ../report.md
rm -rf output
python run.py algo=hnsw dataset=siftsmall "algo.param_index=\
[\
    {ef_construction: 100, M: 4},\
    {ef_construction: 100, M: 16},\
    {ef_construction: 100, M: 32},\
    {ef_construction: 200, M: 4},\
    {ef_construction: 200, M: 16},\
    {ef_construction: 200, M: 32},\
    {ef_construction: 400, M: 4},\
    {ef_construction: 400, M: 16},\
    {ef_construction: 400, M: 32},\
]"
python plot.py
cml-publish ./result_img/siftsmall.png --md >> ../report.md


echo "## Sanity check for scann" >> ../report.md
rm -rf output
python run.py algo=scann dataset=siftsmall "algo.param_index=\
[\
    {num_leaves: 100, reorder: 0},\
    {num_leaves: 100, reorder: 20},\
    {num_leaves: 100, reorder: 40},\
    {num_leaves: 200, reorder: 0},\
    {num_leaves: 200, reorder: 20},\
    {num_leaves: 200, reorder: 40},\
    {num_leaves: 400, reorder: 0},\
    {num_leaves: 400, reorder: 20},\
    {num_leaves: 400, reorder: 40},\
]"
python plot.py
cml-publish ./result_img/siftsmall.png --md >> ../report.md

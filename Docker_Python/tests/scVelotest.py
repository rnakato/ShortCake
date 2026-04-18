#!/usr/bin/env python
# coding: utf-8

# In[1]:


# ライブラリのインポート
import os
import scvelo as scv
import scanpy as sc
import matplotlib.pyplot as plt
import numpy as np
from scipy import sparse
import pandas as pd


# In[2]:


# scVeloのバージョン確認
scv.logging.print_version()


# In[3]:


# 図の出力設定
save_folder = "figures"
os.makedirs(save_folder, exist_ok=True)

scv.settings.autosave = False
scv.settings.autoshow = True

plt.rcParams["savefig.dpi"] = 300
plt.rcParams["figure.figsize"] = [6, 4.5]


# In[4]:


# scVeloの基本設定
scv.settings.verbosity = 3  # show errors(0), warnings(1), info(2), hints(3)
scv.settings.presenter_view = True  # set max width size for presenter view
scv.settings.set_figure_params('scvelo')  # for beautified visualization


# In[5]:


adata = scv.datasets.pancreas()
adata


# In[6]:


scv.pl.proportions(adata)


# In[7]:


# UMAPの可視化と保存
sc.pl.umap(adata, color=["clusters"], show=False)
plt.gcf().savefig(f"{save_folder}/umap.pdf", bbox_inches="tight", dpi=300)
plt.show()


# In[8]:


# gene filtering
scv.pp.filter_genes(adata, min_shared_counts=20)
# normalization
scv.pp.normalize_per_cell(adata)


# In[9]:


sc.pp.log1p(adata)
# scv0.3系では、scvからlog1p()は削除されているため、代わりにscanpyの関数を使用します


# In[10]:


sc.pp.highly_variable_genes(
    adata,
    n_top_genes=2000,
    flavor="seurat"
)

adata = adata[:, adata.var["highly_variable"]].copy()
# scv0.3系では、scvからfilter_genes_dispersion()は削除されているため、代わりにscanpyの関数を使用します


# In[11]:


scv.pp.moments(adata, n_pcs=30, n_neighbors=30)


# In[12]:


scv.tl.velocity(adata)


# In[13]:


scv.tl.velocity_graph(adata)


# In[14]:


# ストリームラインでの可視化と保存
scv.pl.velocity_embedding_stream(
    adata,
    basis="umap",
    show=False
)

fig = plt.gcf()
fig.savefig(
    f"{save_folder}/velocity_stream.pdf",
    dpi=300
)

plt.show()


# In[15]:


# グリッドでの可視化と保存
scv.pl.velocity_embedding_grid(
    adata,
    basis="umap",
    show=False
)

fig = plt.gcf()
fig.savefig(
    f"{save_folder}/velocity_grid.pdf",
    dpi=300
)

plt.show()


# In[16]:


# 細胞レベルでの可視化と保存
scv.pl.velocity_embedding(
    adata,
    basis="umap",
    arrow_length=3,
    arrow_size=2,
    dpi=120,
    show=False
)

fig = plt.gcf()
fig.savefig(
    f"{save_folder}/velocity_arrows.pdf",
    dpi=300
)

plt.show()


# In[17]:


scv.tl.velocity_pseudotime(adata)

scv.pl.scatter(
    adata,
    color="velocity_pseudotime",
    cmap="gnuplot",
    show=False
)

fig = plt.gcf()
fig.savefig(
    f"{save_folder}/velocity_pseudotime.pdf",
    dpi=300
)

plt.show()


# In[18]:


scv.pl.velocity(adata,
                ['Cpe',  'Gnao1', 'Ins2', 'Adk'],
                ncols=2,
               show=False)

fig = plt.gcf()
fig.savefig(
    f"{save_folder}/velocity_gene_visualization.pdf",
    dpi=300
)

plt.show()


# In[19]:


scv.pl.scatter(adata, 'Cpe', color=['clusters', 'velocity'],
               add_outline='Ngn3 high EP, Pre-endocrine, Beta',
              show=False)

fig = plt.gcf()
fig.savefig(
    f"{save_folder}/velocity_Cpe.pdf",
    dpi=300
)

plt.show()


# In[20]:


scv.tl.rank_velocity_genes(adata, groupby="clusters", min_corr=0.3)

df = pd.DataFrame(adata.uns["rank_velocity_genes"]["names"])
df.head()


# In[21]:


kwargs = dict(frameon=False, size=10, linewidth=1.5,
              add_outline='Ngn3 high EP, Pre-endocrine, Beta')

scv.pl.scatter(adata, df['Ngn3 high EP'][:5], ylabel='Ngn3 high EP', **kwargs,
              show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/Ngn3_high_EP.pdf",
    bbox_inches="tight",
    dpi=300
)
plt.show()

scv.pl.scatter(adata, df['Pre-endocrine'][:5], ylabel='Pre-endocrine', **kwargs,
              show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/Pre-endocrine.pdf",
    bbox_inches="tight",
    dpi=300
)
plt.show()


# In[22]:


scv.tl.score_genes_cell_cycle(adata)
scv.pl.scatter(adata, color_gradients=['S_score', 'G2M_score'], smooth=True, perc=[5, 95],
              show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/cell_cycle.pdf",
    bbox_inches="tight",
    dpi=300
)
plt.show()


# In[23]:


s_genes, g2m_genes = scv.utils.get_phase_marker_genes(adata)
s_genes = scv.get_df(adata[:, s_genes], 'spearmans_score', sort_values=True).index
g2m_genes = scv.get_df(adata[:, g2m_genes], 'spearmans_score', sort_values=True).index

kwargs = dict(frameon=False, ylabel='cell cycle genes')
scv.pl.scatter(adata, list(s_genes[:2]) + list(g2m_genes[:3]), **kwargs,
              show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/cell_cycle_genes.pdf",
    bbox_inches="tight",
    dpi=300
)
plt.show()


# In[24]:


scv.pl.velocity(adata, ['Hells', 'Top2a'], ncols=2, add_outline=True,
              show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/Hells_Top2a.pdf",
    dpi=300
)
plt.show()


# In[25]:


scv.tl.velocity_confidence(adata)
keys = 'velocity_length', 'velocity_confidence'
scv.pl.scatter(adata, c=keys, cmap='coolwarm', perc=[5, 95],
              show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/speed_coherence.pdf",
    dpi=300
)
plt.show()


# In[26]:


# 数値として表示する
keys = ['velocity_length', 'velocity_confidence']

df = adata.obs.groupby('clusters')[keys].mean().T
print(df.round(3))


# In[27]:


df = adata.obs.groupby('clusters')[keys].mean().T
df.style.background_gradient(cmap='coolwarm', axis=1)


# In[28]:


scv.pl.velocity_graph(adata, threshold=.1,
              show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/velocity_graph.pdf",
    dpi=300
)
plt.show()


# In[29]:


x, y = scv.utils.get_cell_transitions(adata, basis='umap', starting_cell=70)

ax = scv.pl.velocity_graph(
    adata,
    c='lightgrey',
    edge_width=.05,
    show=False
)

scv.pl.scatter(
    adata,
    x=x,
    y=y,
    s=120,
    c='ascending',
    cmap='gnuplot',
    ax=ax,
    show=False
)

fig = ax.figure
fig.tight_layout(pad=1.2)
fig.savefig(f"{save_folder}/cell_transition.pdf", dpi=300)

plt.show()


# In[30]:


scv.tl.velocity_pseudotime(adata)
scv.pl.scatter(adata, color='velocity_pseudotime', cmap='gnuplot')


# In[31]:


adata.uns['neighbors']['distances'] = adata.obsp['distances']
adata.uns['neighbors']['connectivities'] = adata.obsp['connectivities']

scv.tl.paga(adata, groups='clusters')
df = scv.get_df(adata, 'paga/transitions_confidence', precision=2).T
print(df.round(2))


# In[32]:


scv.pl.paga(adata, basis='umap', size=50, alpha=.1,
            min_edge_width=2, node_size_scale=1.5,
              show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/paga_velocity_graph.pdf",
    bbox_inches="tight",
    dpi=300
)
plt.show()


# In[33]:


scv.tl.recover_dynamics(adata)


# In[34]:


scv.tl.velocity(adata, mode='dynamical')
scv.tl.velocity_graph(adata)


# In[35]:


scv.pl.velocity_embedding_stream(adata, basis='umap')


# In[36]:


df = adata.var
df = df[(df['fit_likelihood'] > .1) & df['velocity_genes'] == True]

kwargs = dict(xscale='log', fontsize=16)
with scv.GridSpec(ncols=3) as pl:
    pl.hist(df['fit_alpha'], xlabel='transcription rate', **kwargs)
    pl.hist(df['fit_beta'] * df['fit_scaling'], xlabel='splicing rate', xticks=[.1, .4, 1], **kwargs)
    pl.hist(df['fit_gamma'], xlabel='degradation rate', xticks=[.1, .4, 1], **kwargs)

scv.get_df(adata, 'fit*', dropna=True).head()


# In[37]:


scv.tl.latent_time(adata)
scv.pl.scatter(adata, color='latent_time', color_map='gnuplot', size=80,
               show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/latent_time.pdf",
    dpi=300
)
plt.show()


# In[38]:


top_genes = adata.var['fit_likelihood'].sort_values(ascending=False).index[:300]
scv.pl.heatmap(adata, var_names=top_genes, sortby='latent_time', col_color='clusters', n_convolve=100,
               show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/latent_time_heatmap.pdf",
    bbox_inches="tight",
    dpi=300
)
plt.show()


# In[39]:


top_genes = adata.var['fit_likelihood'].sort_values(ascending=False).index
scv.pl.scatter(adata, basis=top_genes[:15], ncols=5, frameon=False,
               show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/top_liklihood.pdf",
    bbox_inches="tight",
    dpi=300
)
plt.show()


# In[40]:


var_names = ['Actn4', 'Ppp3ca', 'Cpe', 'Nnat']
scv.pl.scatter(adata, var_names, frameon=False,
               show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/four_liklihood.pdf",
    bbox_inches="tight",
    dpi=300
)
plt.show()

scv.pl.scatter(adata, x='latent_time', y=var_names, frameon=False,
               show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/four_liklihood_latenttime.pdf",
    bbox_inches="tight",
    dpi=300
)
plt.show()


# In[41]:


scv.tl.rank_dynamical_genes(adata, groupby='clusters')
df = scv.get_df(adata, 'rank_dynamical_genes/names')
df.head(5)


# In[42]:


for cluster in ['Ductal', 'Ngn3 high EP', 'Pre-endocrine', 'Beta']:
    scv.pl.scatter(adata, df[cluster][:5], ylabel=cluster, frameon=False,
                   show=False)
fig = plt.gcf()
fig.savefig(
    f"{save_folder}/cluster_liklihood.pdf",
    bbox_inches="tight",
    dpi=300
)
plt.show()


# In[43]:


# 歯状回データのロード
adata=scv.datasets.dentategyrus()
adata


# In[44]:


scv.pl.proportions(adata)


# In[45]:


scv.pp.filter_genes(adata, min_shared_counts=20)
scv.pp.normalize_per_cell(adata)
scv.pp.moments(adata, n_pcs=30, n_neighbors=30)


# In[ ]:

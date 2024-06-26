process SCVI {
    label 'gpus'
    container "library://mamie_wang/nf-scrnaseq/scvi.sif:latest"
    containerOptions '--nv'
    publishDir "${params.outdir}/scvi/", mode: 'copy'

    input:
    path scran_h5ad

    output:
    path "${params.experiment.name ? params.experiment.name + '_' : ''}scvi.h5ad", emit: scvi_h5ad

    script:
    """
    export NUMBA_CACHE_DIR=/tmp/numba_cache
    python ${baseDir}/bin/scvi_norm.py \
        ${scran_h5ad} \
        ${params.experiment.name ? params.experiment.name + '_' : ''}scvi.h5ad \
        --n_latent ${params.scvi.n_latent} \
        --n_top_genes ${params.scvi.n_top_genes}
    """
}

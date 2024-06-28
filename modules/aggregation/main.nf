process AGGREGATION {
    label 'process_low'
    container 'library://mamie_wang/nf-scrnaseq/doubletdetection.sif:latest'
    publishDir "${params.outdir}/aggregation/", mode: 'copy'

    input:
    val doublet_h5ads

    output:
    path "${params.experiment.name ? params.experiment.name + '_' : ''}aggregation.h5ad", emit: aggregation_h5ad

    script:
    joined_file_paths = doublet_h5ads.join(' ')
    """
    python ${baseDir}/bin/aggregation.py \
        ${joined_file_paths} \
        --output "${params.experiment.name ? params.experiment.name + '_' : ''}aggregation.h5ad"
    """
}

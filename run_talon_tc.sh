#!/bin/sh
#SBATCH -n 16
#SBATCH -A seyedam_lab
#SBATCH --output=talon.out
#SBATCH --error=talon.err
#SBATCH --time=48:00:00
#SBATCH -J talon_pgp
#SBATCH --mem=64G
#SBATCH --mail-type=START,END
#SBATCH --mail-user=freese@uci.edu

source ~/.bash_profile
conda activate base

# references
genome=/share/crsp/lab/seyedam/share/TALON_paper_data/revisions_1-20/refs/hg38_SIRV/hg38_SIRV.fa
sjs=/share/crsp/lab/seyedam/share/PACBIO/refs/gencode_v29_SIRV_SJs.tsv 
annot=/dfs6/pub/freese/mortazavi_lab/ref/gencode.v29/gencode.v29.SIRV.ERCC.annotation.gtf

# # minimap 
# astro_1=/share/crsp/lab/seyedam/share/PACBIO/PB306/Refine/A01/flnc.fastq
# odir_1=/share/crsp/lab/seyedam/share/PACBIO/PB306/Minimap2/
# astro_2=/share/crsp/lab/seyedam/share/PACBIO/PB307/Refine/B01/flnc.fastq
# odir_2=/share/crsp/lab/seyedam/share/PACBIO/PB307/Minimap2/

# mkdir -p $odir_1
# mkdir -p $odir_2

# module load samtools
# module load minimap2/2.17

# minimap2 \
#     -t 16 \
#     -ax splice:hq \
#     -uf \
#     --MD \
#     $genome \
#     $astro_1 > \
#     $odir_1/mapped_flnc.sam 2> \
#     $odir_1/mapped_flnc.log
    
# minimap2 \
#     -t 16 \
#     -ax splice:hq \
#     -uf \
#     --MD \
#     $genome \
#     $astro_2 > \
#     $odir_2/mapped_flnc.sam 2> \
#     $odir_2/mapped_flnc.log


# # transcriptclean
# astro_1=/share/crsp/lab/seyedam/share/PACBIO/PB306/Minimap2/mapped_flnc.sam
# astro_2=/share/crsp/lab/seyedam/share/PACBIO/PB307/Minimap2/mapped_flnc.sam

# samtools view -Sb $astro_1 > $odir_1/mapped_flnc.bam
# samtools sort $odir_1/mapped_flnc.bam > $odir_1/mapped_flnc_sorted.bam
# samtools view -h $odir_1/mapped_flnc_sorted.bam > $odir_1/mapped_flnc_sorted.sam

# samtools view -Sb $astro_2 > $odir_2/mapped_flnc.bam
# samtools sort $odir_2/mapped_flnc.bam > $odir_2/mapped_flnc_sorted.bam
# samtools view -h $odir_2/mapped_flnc_sorted.bam > $odir_2/mapped_flnc_sorted.sam

# astro_1=/share/crsp/lab/seyedam/share/PACBIO/PB306/Minimap2/mapped_flnc_sorted.sam
# astro_2=/share/crsp/lab/seyedam/share/PACBIO/PB307/Minimap2/mapped_flnc_sorted.sam
# odir_1=/share/crsp/lab/seyedam/share/PACBIO/PB306/TC/
# odir_2=/share/crsp/lab/seyedam/share/PACBIO/PB307/TC/

# tc_path=/dfs6/pub/freese/mortazavi_lab/bin/TranscriptClean/
# python ${tc_path}/TranscriptClean.py \
#     --sam $astro_1 \
#     --genome $genome \
#     --spliceJns $sjs \
#     -t 16 \
#     --canonOnly \
#     --deleteTmp \
#     --outprefix $odir_1/tc
    
# python ${tc_path}/TranscriptClean.py \
#     --sam $astro_2 \
#     --genome $genome \
#     --spliceJns $sjs \
#     -t 16 \
#     --canonOnly \
#     --deleteTmp \
#     --outprefix $odir_2/tc

# talon label reads
pb_dir=/share/crsp/lab/seyedam/share/PACBIO/

# pgp_1=/share/crsp/lab/seyedam/share/PACBIO/PB103/TC_v1.0.7/sorted_canonical.sam
# pgp_2=/share/crsp/lab/seyedam/share/PACBIO/PB104/TC_v1.0.7/sorted_canonical.sam

# neuro_1=/share/crsp/lab/seyedam/share/PACBIO/PB105/TC_v1.0.7/sorted_canonical.sam
# neuro_2=/share/crsp/lab/seyedam/share/PACBIO/PB106/TC_v1.0.7/sorted_canonical.sam

# astro_1=/share/crsp/lab/seyedam/share/PACBIO/PB306/TC/tc_clean.sam
# astro_2=/share/crsp/lab/seyedam/share/PACBIO/PB307/TC/tc_clean.sam

# echo "Labelling reads"

# id=PB103
# sam=${pb_dir}$id/TC_v1.0.7/sorted_canonical.sam
# mkdir -p ${pb_dir}$id/labelReads/
# talon_label_reads \
#     --f $sam \
#     --g $genome \
#     --t 16 \
#     --ar 20  \
#     --deleteTmp  \
#     --o ${pb_dir}$id/labelReads/talon

# id=PB104
# sam=${pb_dir}$id/TC_v1.0.7/sorted_canonical.sam
# mkdir -p ${pb_dir}$id/labelReads/
# talon_label_reads \
#     --f $sam \
#     --g $genome \
#     --t 16 \
#     --ar 20  \
#     --deleteTmp  \
#     --o ${pb_dir}$id/labelReads/talon

# id=PB105
# sam=${pb_dir}$id/TC_v1.0.7/sorted_canonical.sam
# mkdir -p ${pb_dir}$id/labelReads/
# talon_label_reads \
#     --f $sam \
#     --g $genome \
#     --t 16 \
#     --ar 20  \
#     --deleteTmp  \
#     --o ${pb_dir}$id/labelReads/talon

# id=PB106
# sam=${pb_dir}$id/TC_v1.0.7/sorted_canonical.sam
# mkdir -p ${pb_dir}$id/labelReads/
# talon_label_reads \
#     --f $sam \
#     --g $genome \
#     --t 16 \
#     --ar 20  \
#     --deleteTmp  \
#     --o ${pb_dir}$id/labelReads/talon
    
# id=PB306
# sam=${pb_dir}$id/TC/tc_clean.sam
# mkdir -p ${pb_dir}$id/labelReads/
# talon_label_reads \
#     --f $sam \
#     --g $genome \
#     --t 16 \
#     --ar 20  \
#     --deleteTmp  \
#     --o ${pb_dir}$id/labelReads/talon
    
# id=PB307
# sam=${pb_dir}$id/TC/tc_clean.sam
# mkdir -p ${pb_dir}$id/labelReads/
# talon_label_reads \
#     --f $sam \
#     --g $genome \
#     --t 16 \
#     --ar 20  \
#     --deleteTmp  \
#     --o ${pb_dir}$id/labelReads/talon

# init talon DB
# echo "Initializing TALON database"
p_dir=/dfs6/pub/freese/mortazavi_lab/data/210413_pgp/talon/
# mkdir -p $p_dir
# talon_initialize_database \
#     --f $annot \
#     --g hg38 \
#     --a gencode_v29 \
#     --l 0 \
#     --idprefix ENCODEH \
#     --5p 500 \
#     --3p 300 \
#     --o ${p_dir}/pgp1
    
# run talon
echo "Running TALON"
talon \
    --f ${p_dir}config.csv \
    --db ${p_dir}pgp1.db \
    --build hg38 \
    --t 16 \
    --o ${p_dir}pgp1

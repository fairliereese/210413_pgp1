#!/bin/sh
##SBATCH -A SEYEDAM_LAB
#SBATCH --output=filter_ends.out
#SBATCH --error=filter_ends.err
#SBATCH --time=06:00:00
#SBATCH -J filter_ends
#SBATCH --mail-type=START,END
#SBATCH --partition=standard
#SBATCH --mem 32G

source ~/.bash_profile
module load samtools

picard_path=/opt/apps/picard-tools/1.87/

in_bam=talon_tmp/merged.bam
out_bam=talon_tmp/merged_rg.bam
tss_reads=tss_read_names.txt
tss_out=tss_reads.bam

# first add the RG header tags for each RG
rg_tags="pgp1_1 pgp1_2 excite_neuron_1 excite_neuron_2 astro_1 astro_2"
samtools view -H $in_bam > header.sam
for tag in $rg_tags
do
    printf "@RG\tID:${tag}\tPL:PacBio\tSM:PGP1\n" >> header.sam
done
samtools reheader header.sam $in_bam > $out_bam

java -jar ${picard_path}FilterSamReads.jar \
    I=$out_bam \
    O=$tss_out \
    READ_LIST_FILE=$tss_reads \
    FILTER=includeReadList \
    CREATE_INDEX=true
    
samtools index $tss_out
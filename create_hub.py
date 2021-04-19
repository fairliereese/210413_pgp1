import os
import shlex
import pandas as pd
import subprocess

def make_bam_hub_entry(df, c_dict, ofile):
    with open(ofile, 'w') as o:
        for ind, e in df.iterrows():
            c = c_dict[e['sample']]
            c = c.lstrip('#')
            c = tuple(int(c[i:i+2], 16) for i in (0, 2, 4))

            s = 'track {}_reads\n'.format(e['sample'])
            s += 'bigDataUrl {}\n'.format(e.url)
            s += 'shortLabel {}_reads\n'.format(e['sample'])
            s += 'longLabel {}_reads\n'.format(e['sample'])
            s += 'type bam\n'
            s += 'visibility squish\n'
            s += 'bamColorMode off\n'
            s += 'color {},{},{}\n\n'.format(c[0],c[1],c[2])
            o.write(s)

# "input"
url = 'http://crick.bio.uci.edu/freese/210413_pgp1_hub/'
c_dict = {'astro_1': '#f6ef7c', 'astro_2': '#eabc68',\
          'excite_neuron_1': '#e4d3cd', 'excite_neuron_2': '#d3a8b2',\
          'pgp1_1': '#bef4ff', 'pgp1_2': '#73a8b2'}
config = 'talon/config.csv'
genome = 'hg38'
hub_name = 'pgp1'
email = 'freese@uci.edu'
scp_location = 'freese@crick.bio.uci.edu:~/pub/210413_pgp1_hub/'


genomefile = 'hub/genomes.txt'
hubfile = 'hub/hub.txt'
hubfile_relative = 'hub.txt'
trackdb = 'hub/{}/trackDb.txt'.format(genome)
relative_trackdb = '{}/trackDb.txt'.format(genome)
relative_genome = 'genomes.txt'
try:
    os.makedirs(os.path.dirname(trackdb))
except:
    pass
df = pd.read_csv(config, header=None, names=['sample', 'condition', \
                                             'platform', 'filepath'])
df['url'] = df.apply(lambda x: url+x['sample']+'.bam', axis=1)
df['local_loc'] = df.apply(lambda x: 'talon_tmp/'+x['sample']+'.bam', axis=1)

for ind, entry in df.iterrows():
    cmd = 'samtools index {}'.format(entry.local_loc)
    print(cmd)
    cmd = shlex.split(cmd)
    result = subprocess.run(cmd)  
    
    cmd = 'scp {} {}'.format(entry.local_loc, scp_location)
    cmd = shlex.split(cmd)
    print(cmd)
    result = subprocess.run(cmd)
    
    cmd = 'scp {}.bai {}'.format(entry.local_loc, scp_location)
    cmd = shlex.split(cmd)
    print(cmd)
    result = subprocess.run(cmd)
    
    
make_bam_hub_entry(df, c_dict, trackdb)

with open(genomefile, 'w') as o:
    s = 'genome {}\n'.format(genome)
    s += 'trackDb {}\n'.format(relative_trackdb)
    o.write(s)

with open(hubfile, 'w') as o:
    s = 'hub {}\n'.format(hub_name)
    s += 'shortLabel {}\n'.format(hub_name)
    s += 'longLabel {}\n'.format(hub_name)
    s += 'genomesFile {}\n'.format(relative_genome)
    s += 'email {}\n'.format(email)
    o.write(s)

cmd = 'scp -r hub/* {}'.format(scp_location)
cmd = shlex.split(cmd)
result = subprocess.run(cmd)
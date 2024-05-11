# unpacked from hg38.chromFa.tar.gz
hg38 = "/home/ctbrown/scratch/host/human/hg38/chroms/"

HG38_CHR, = glob_wildcards(hg38 + "{chr}.fa")
print(f'found {len(HG38_CHR)} chromosome files in {hg38}')

rule all:
    input:
        "hg38-entire.sig.zip"

rule sketch:
    input:
        expand(hg38 + "{chr}.fa", chr=HG38_CHR),
    output:
        "hg38-entire.sig.zip"
    params:
        name="hg38-entire"
    shell: """
        sourmash sketch dna -p k=21,k=31,k=51,abund {input} -o {output} \
            --name {params.name:q}
    """

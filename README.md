# dna-align-dataset

This repository contains notes on how to generate DNA string alignment dataset from real datasets from NCBI Bioproject on Ubuntu.

## Getting started

First we need to download the SRA toolkit of NCBI in order to download dataset from NCBI Bioproject. Here we use version 3.0.0. If there is a newer version, check out the [sra-tools repository](https://github.com/ncbi/sra-tools).

```bash
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.0.0/sratoolkit.3.0.0-ubuntu64.tar.gz
tar -xvf sratoolkit.3.0.0-ubuntu64.tar.gz
cd sratoolkit.3.0.0-ubuntu64/bin
echo "export PATH=\${PATH}:$(pwd)" >> ~/.bashrc
source ~/.bashrc
```

You may want to run `vdb-config --interactive` first before testing the installation with `prefetch`.

## Download SRA datasets

After entering a project (we use PRJNA178613 as an example), see the table `Project Data`, click on the `Number of Links` number and there will be a list of links to runs. Click on one of the links and you will see an accession ID starting with `SRR`. Copy that ID (e.g. SRR611076) and run

```bash
prefetch SRR611076
```

It takes around 1.5 hours to download this dataset. Next we can see that an `.sra` file is downloaded in `./SRR611076`. We can then convert the file into fastq file with

```bash
cd SRR611076/
fastq-dump --split-files SRR611076.sra
```

We use `--split-files` because this dataset has `PAIRED` layout. After waiting some time we can see that two fastq files are generated.

## Create draft alignment

We use BWA as the sequence mapper. First we can download a reference genome of the species (`sequence.fasta` here) to the following.


```bash
bwa index -p test sequence.fasta
bwa mem -M -t 1 test SRR611076_1.fastq SRR611076_2.fastq > SRR611076.sam
```

This creates a [.sam file](https://www.zymoresearch.com/blogs/blog/what-are-sam-and-bam-files), which records the possible position of mapping. We can then use this to generate a string alignment dataset with the script `generate_dataset.sh`. To use this we can do the following

```bash
chmod +x generate_dataset.sh
generate_dataset.sh [sam_file] [fasta_file] > [output_directory]
```


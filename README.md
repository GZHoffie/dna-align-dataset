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


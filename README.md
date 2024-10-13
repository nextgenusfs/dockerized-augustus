##### dockerized Augustus 

This is a hacky way to run/install augustus with docker.  Why?  Well I develop on Mac OSX and some features of Augustus stopped working when I upgraded computers to apple silicon, so this little repo will allow you to build a working Augustus docker image and then "spoof" the scripts so that you can put this in your PATH and it can be picked up by some other software, ie `funannotate` or `funannotate2`.

```
docker build -t augustus .
```

This command will install augustus in the docker image.

```
$ augustus

AUGUSTUS (3.5.0) is a gene prediction tool.
Sources and documentation at https://github.com/Gaius-Augustus/Augustus

usage:
augustus [parameters] --species=SPECIES queryfilename

'queryfilename' is the filename (including relative path) to the file containing the query sequence(s)
in fasta format.

SPECIES is an identifier for the species. Use --species=help to see a list.

parameters:
--strand=both, --strand=forward or --strand=backward
--genemodel=partial, --genemodel=intronless, --genemodel=complete, --genemodel=atleastone or --genemodel=exactlyone
  partial      : allow prediction of incomplete genes at the sequence boundaries (default)
  intronless   : only predict single-exon genes like in prokaryotes and some eukaryotes
  complete     : only predict complete genes
  atleastone   : predict at least one complete gene
  exactlyone   : predict exactly one complete gene
--singlestrand=true
  predict genes independently on each strand, allow overlapping genes on opposite strands
  This option is turned off by default.
--hintsfile=hintsfilename
  When this option is used the prediction considering hints (extrinsic information) is turned on.
  hintsfilename contains the hints in gff format.
--AUGUSTUS_CONFIG_PATH=path
  path to config directory (if not specified as environment variable)
--alternatives-from-evidence=true/false
  report alternative transcripts when they are suggested by hints
--alternatives-from-sampling=true/false
  report alternative transcripts generated through probabilistic sampling
--sample=n
--minexonintronprob=p
--minmeanexonintronprob=p
--maxtracks=n
  For a description of these parameters see section 2 of RUNNING-AUGUSTUS.md.
--proteinprofile=filename
  When this option is used the prediction will consider the protein profile provided as parameter.
  The protein profile extension is described in section 5 of RUNNING-AUGUSTUS.md.
--progress=true
  show a progressmeter
--gff3=on/off
  output in gff3 format
--predictionStart=A, --predictionEnd=B
  A and B define the range of the sequence for which predictions should be found.
--UTR=on/off
  predict the untranslated regions in addition to the coding sequence. This currently works only for a subset of species.
--noInFrameStop=true/false
  Do not report transcripts with in-frame stop codons. Otherwise, intron-spanning stop codons could occur. Default: false
--noprediction=true/false
  If true and input is in genbank format, no prediction is made. Useful for getting the annotated protein sequences.
--uniqueGeneId=true/false
  If true, output gene identifyers like this: seqname.gN
--/Testing/testMode=prepare, --/Testing/testMode=run, (disabled by default)
  prepare      : prepare a new minimal data set to test comparative Augustus
  intronless   : run prediction over some given minimal data set
  (*) a minimal data set is one retaining only the information need in prediction, usually very small (order of Mb) compared to full sequence data sets (ordet of Gb)

For a complete list of parameters, type "augustus --paramlist". A description of the important ones can be found in the file RUNNING-AUGUSTUS.md.

```
TARGETS = [f"fastq/SRR{tag+10669441}/end.txt" for tag in range(26)]

rule all:
	input: TARGETS

rule download_with_wget:
	output:	temp("SRR{tagno}")
	shell: "wget -q https://sra-pub-run-odp.s3.amazonaws.com/sra/{output}/{output}"

rule dump_fastq_from_sra:
	input: temp("SRR{tagno}")
	output: touch("fastq/SRR{tagno}/end.txt")
	conda: "sratoolkit.yaml"
	shell: "mkdir -p {output}; fasterq-dump --outdir {output} {input}"

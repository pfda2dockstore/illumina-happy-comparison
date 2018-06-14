# Generated by precisionFDA exporter (v1.0.3) on 2018-06-14 15:46:55 +0000
# The asset download links in this file are valid only for 24h.

# Exported app: illumina-happy-comparison, revision: 47, authored by: peter.krusche
# https://precision.fda.gov/apps/app-F5YXbp80PBYFP059656gYxXQ

# For more information please consult the app export section in the precisionFDA docs

# Start with Ubuntu 14.04 base image
FROM ubuntu:14.04

# Install default precisionFDA Ubuntu packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	aria2 \
	byobu \
	cmake \
	cpanminus \
	curl \
	dstat \
	g++ \
	git \
	htop \
	libboost-all-dev \
	libcurl4-openssl-dev \
	libncurses5-dev \
	make \
	perl \
	pypy \
	python-dev \
	python-pip \
	r-base \
	ruby1.9.3 \
	wget \
	xz-utils

# Install default precisionFDA python packages
RUN pip install \
	requests==2.5.0 \
	futures==2.2.0 \
	setuptools==10.2

# Add DNAnexus repo to apt-get
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/amd64/' > /etc/apt/sources.list.d/dnanexus.list"
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/all/' >> /etc/apt/sources.list.d/dnanexus.list"
RUN curl https://wiki.dnanexus.com/images/files/ubuntu-signing-key.gpg | apt-key add -

# Install app-specific Ubuntu packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	python-jinja2 \
	python-psutil

# Download app assets
RUN curl https://dl.dnanex.us/F/D/VqFqYkj1Xy0y3z52kxXVBV5XKg6jqB1FyYkGqGG5/ga4gh-benchmarking-tools-0.1a.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/Y60KGZfvvv6bqvfGpxPQ36VfKPf7kb5PYj1YPff7/ga4gh-report-v0.1.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/2j1Q674GqfjkyZyKGFQzp4vfZkJZ6fYZKj4GXJXJ/hap.py-hg19.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/qZB37vgx6z4QQzq0KvfXbJK0qV0kGyJ2z9zYy35v/hap.py-hg38.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/Yq0P4qZJ64FG801By09vG47x35q2vPZG737qFzyB/hap.py-v0.3.10-pre1.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/V2zxgY643xvY9361pv5qQgF58K1b06066pFqPJVf/hs37d5-fasta.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/JX3bG71kpFzBxbY8xp6PgKFQgQz73Pv2Y7kF02B3/rtg-hs37d5.tar | tar xf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/f4283yp5q87B893ZFQKq1ZPFV3ZBQG4j2j2kpYV2/rtg-tools-3.8.2-with-refpatch.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions

# Download helper executables
RUN curl https://dl.dnanex.us/F/D/0K8P4zZvjq9vQ6qV0b6QqY1z2zvfZ0QKQP4gjBXp/emit-1.0.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/bByKQvv1F7BFP3xXPgYXZPZjkXj9V684VPz8gb7p/run-1.2.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions

# Write app spec and code to root folder
RUN ["/bin/bash","-c","echo -E \\{\\\"spec\\\":\\{\\\"input_spec\\\":\\[\\{\\\"name\\\":\\\"truth_vcf\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Truth\\\",\\\"help\\\":\\\"This\\ is\\ the\\ truthset\\ file,\\ for\\ example\\ a\\ Platinum\\ Genomes\\ or\\ Genome\\ in\\ a\\ Bottle\\ VCF.\\\",\\\"default\\\":\\\"file-F30Z2ZQ079PbY5Bx1BQ01Fkv\\\"\\},\\{\\\"name\\\":\\\"truth_bed\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Truth\\ confident\\ regions\\\",\\\"help\\\":\\\"These\\ are\\ the\\ confident\\ regions\\ for\\ the\\ truthset.\\\",\\\"default\\\":\\\"file-F30Z3Bj079PyBPgY1zKVg7P4\\\"\\},\\{\\\"name\\\":\\\"reference\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Reference\\ Genome\\\",\\\"help\\\":\\\"The\\ reference\\ sequence\\ to\\ use.\\ This\\ must\\ match\\ the\\ reference\\ used\\ for\\ your\\ truth\\ and\\ query\\ VCFs.\\\",\\\"default\\\":\\\"hs37d5\\\",\\\"choices\\\":\\[\\\"hg19\\\",\\\"hs37d5\\\",\\\"hg38\\\"\\]\\},\\{\\\"name\\\":\\\"query_method\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Label\\ \\(1\\)\\\",\\\"help\\\":\\\"A\\ label\\ for\\ the\\ query\\ \\(e.g.\\ the\\ name\\ of\\ the\\ variant\\ calling\\ method\\)\\\",\\\"default\\\":\\\"Method\\ 1\\\"\\},\\{\\\"name\\\":\\\"query_vcf\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Query\\ \\(1\\)\\\",\\\"help\\\":\\\"The\\ VCF\\ file\\ to\\ benchmark\\\"\\},\\{\\\"name\\\":\\\"query_2_method\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Label\\ \\(2\\)\\\",\\\"help\\\":\\\"A\\ label\\ for\\ the\\ second\\ query\\ \\(e.g.\\ the\\ name\\ of\\ the\\ variant\\ calling\\ method\\)\\\",\\\"default\\\":\\\"Method\\ 2\\\"\\},\\{\\\"name\\\":\\\"query_2_vcf\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Query\\ \\(2\\)\\\",\\\"help\\\":\\\"\\(optional\\)\\ a\\ second\\ query\\ file,\\ useful\\ when\\ benchmarking\\ comparisons\\\"\\},\\{\\\"name\\\":\\\"target_bed\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Target\\ regions\\\",\\\"help\\\":\\\"\\(optional\\)\\ target\\ regions\\ covered\\ by\\ the\\ query\\ VCF\\ file\\\"\\},\\{\\\"name\\\":\\\"comparison_method\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Comparison\\ Method\\\",\\\"help\\\":\\\"The\\ comparison\\ method\\ to\\ use\\\",\\\"default\\\":\\\"vcfeval-no-partialcredit\\\",\\\"choices\\\":\\[\\\"xcmp-no-partialcredit\\\",\\\"xcmp-partialcredit\\\",\\\"vcfeval-no-partialcredit\\\",\\\"vcfeval-partialcredit\\\",\\\"allelebased-no-partialcredit\\\",\\\"allelebased-partialcredit\\\",\\\"distance-based\\\"\\]\\},\\{\\\"name\\\":\\\"distance_threshold\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Distance\\ Threshold\\\",\\\"help\\\":\\\"For\\ distance-based\\ matching,\\ how\\ far\\ do\\ variants\\ need\\ to\\ be\\ apart\\\",\\\"default\\\":30,\\\"choices\\\":\\[1,3,10,30,50,100,1000\\]\\},\\{\\\"name\\\":\\\"adjust_conf_regions\\\",\\\"class\\\":\\\"boolean\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Adjust\\ confident\\ regions\\\",\\\"help\\\":\\\"Correct\\ the\\ confident\\ regions\\ for\\ insertion\\ padding\\ \\(base\\ before\\ and\\ after\\)\\\",\\\"default\\\":true\\},\\{\\\"name\\\":\\\"use_stratification\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Pre-defined\\ stratification\\ regions\\\",\\\"help\\\":\\\"Stratification\\ regions\\ to\\ use\\ \\(only\\ available\\ for\\ hg19\\ and\\ hs37d5\\)\\\",\\\"default\\\":\\\"none\\\",\\\"choices\\\":\\[\\\"none\\\",\\\"repeats\\\",\\\"other\\\"\\]\\},\\{\\\"name\\\":\\\"custom_stratification\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Custom\\ stratification\\ regions\\\",\\\"help\\\":\\\"Upload\\ a\\ tar\\ file\\ with\\ custom\\ stratification\\ regions.\\ This\\ tarball\\ must\\ include\\ a\\ single\\ tsv\\ file\\ in\\ the\\ root\\ directory\\ which\\ will\\ be\\ used\\ as\\ the\\ --stratification\\ input\\ for\\ hap.py\\\"\\},\\{\\\"name\\\":\\\"sample_gender\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Sample\\ Gender\\\",\\\"help\\\":\\\"The\\ sample\\ gender\\ determines\\ how\\ calls\\ on\\ chrX\\ are\\ handled.\\ Automatic\\ detection\\ will\\ check\\ if\\ all\\ truth\\ calls\\ on\\ chrX\\ are\\ haploid\\ in\\ order\\ to\\ tell\\ if\\ a\\ sample\\ is\\ male.\\\",\\\"default\\\":\\\"female\\\",\\\"choices\\\":\\[\\\"auto\\\",\\\"male\\\",\\\"female\\\",\\\"none\\\"\\]\\}\\],\\\"output_spec\\\":\\[\\{\\\"name\\\":\\\"report_html\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"HTML\\ file\\ with\\ report\\\",\\\"help\\\":\\\"A\\ summary\\ report\\ with\\ the\\ comparison\\ results\\\"\\},\\{\\\"name\\\":\\\"detailed_results\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Archive\\ with\\ detailed\\ results\\\",\\\"help\\\":\\\"This\\ archive\\ contains\\ the\\ full\\ hap.py\\ outputs,\\ including\\ an\\ annotated\\ VCF\\ file\\ and\\ full\\ ROC\\ data\\\"\\},\\{\\\"name\\\":\\\"happy_log\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Hap.py\\ log\\ for\\ first\\ query\\\",\\\"help\\\":\\\"Hap.py\\ logfile\\\"\\}\\],\\\"internet_access\\\":false,\\\"instance_type\\\":\\\"baseline-16\\\"\\},\\\"assets\\\":\\[\\\"file-F30jKgj079PzY8fv0bkJpV92\\\",\\\"file-F319538079Pzq5Yy9yGyzX56\\\",\\\"file-Bv5qpv8079Pb9v55kQ4320YB\\\",\\\"file-F2z8V8Q079Pxvq8g82Pv8fZ2\\\",\\\"file-F5Y1FKQ079PxFx1315QVJ2Z0\\\",\\\"file-Bk5y43Q0qVb0gjfqY8f9k4g8\\\",\\\"file-BqB6zV80qVb8Xb31P0B97jPg\\\",\\\"file-F5YXV10079PfJZ4j76B1bZ0g\\\"\\],\\\"packages\\\":\\[\\\"python-jinja2\\\",\\\"python-psutil\\\"\\]\\} \u003e /spec.json"]
RUN ["/bin/bash","-c","echo -E \\{\\\"code\\\":\\\"set\\ -e\\\\n\\\\nexport\\ HGREF\\=/work/hg19.fa\\\\n\\\\n\\#\\ set\\ up\\ reference\\\\nif\\ \\[\\[\\ \\!\\ -f\\ /work/\\$\\{reference\\}.fa\\ \\ \\]\\]\\;\\ then\\\\n\\ \\ echo\\ \\\\\\\"Invalid\\ choice\\ for\\ the\\ reference\\ sequence:\\ \\$\\{reference\\}\\\\\\\"\\\\n\\ \\ exit\\ 1\\\\nfi\\\\n\\\\nexport\\ HGREF\\=\\\\\\\"/work/\\$\\{reference\\}.fa\\\\\\\"\\\\necho\\ \\\\\\\"using\\ reference\\ sequence\\ \\$\\{HGREF\\}\\\\\\\"\\\\n\\\\nif\\ \\[\\[\\ \\\\\\\"\\$\\{reference\\}\\\\\\\"\\ \\=\\=\\ \\\\\\\"hg19\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ fixchr\\=true\\\\nelse\\\\n\\ \\ fixchr\\=false\\\\nfi\\\\n\\\\nmkdir\\ -p\\ results\\\\n\\\\nHXX\\=\\\\\\\"-r\\ \\$\\{HGREF\\}\\ --verbose\\ --gender\\ \\$\\{sample_gender\\}\\\\\\\"\\\\nCOMPARISON_METHOD\\=\\\\\\\"\\$\\{reference\\}\\\\\\\"\\\\n\\\\nif\\ \\[\\[\\ \\\\\\\"\\$truth_bed\\\\\\\"\\ \\!\\=\\ \\\\\\\"\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ \\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ -f\\ \\$\\{truth_bed_path\\}\\\\\\\"\\\\nfi\\\\n\\\\nif\\ \\$fixchr\\;\\ then\\\\n\\ \\ echo\\ \\\\\\\"Adding\\ chr\\ prefix\\ if\\ necessary.\\\\\\\"\\\\n\\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --fixchr\\\\\\\"\\\\nfi\\\\n\\\\nif\\ \\$adjust_conf_regions\\;\\ then\\\\n\\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --adjust-conf-regions\\\\\\\"\\\\nelse\\\\n\\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --no-adjust-conf-regions\\\\\\\"\\\\nfi\\\\n\\\\nif\\ \\[\\[\\ \\\\\\\"\\$comparison_method\\\\\\\"\\ \\=\\=\\ xcmp\\*\\ \\]\\]\\;\\ then\\\\n\\ \\ echo\\ \\\\\\\"Using\\ xcmp\\ for\\ comparison\\\\\\\"\\\\n\\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --engine\\=xcmp\\\\\\\"\\\\n\\ \\ COMPARISON_METHOD\\=\\\\\\\"\\$\\{COMPARISON_METHOD\\}-xcmp\\\\\\\"\\\\nfi\\\\n\\\\nif\\ \\[\\[\\ \\\\\\\"\\$comparison_method\\\\\\\"\\ \\=\\=\\ vcfeval\\*\\ \\]\\]\\;\\ then\\\\n\\ \\ echo\\ \\\\\\\"Using\\ vcfeval\\ for\\ comparison\\\\\\\"\\\\n\\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --engine\\=vcfeval\\ --engine-vcfeval-path\\=/opt/rtg/rtg\\\\\\\"\\\\n\\ \\ COMPARISON_METHOD\\=\\\\\\\"\\$\\{COMPARISON_METHOD\\}-vcfeval\\\\\\\"\\\\nfi\\\\n\\\\nif\\ \\[\\[\\ \\\\\\\"\\$comparison_method\\\\\\\"\\ \\=\\=\\ allelebased\\*\\ \\]\\]\\;\\ then\\\\n\\ \\ echo\\ \\\\\\\"Using\\ allele-based\\ comparison\\\\\\\"\\\\n\\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --engine\\=scmp-somatic\\\\\\\"\\\\n\\ \\ COMPARISON_METHOD\\=\\\\\\\"\\$\\{COMPARISON_METHOD\\}-allelebased\\\\\\\"\\\\nfi\\\\n\\\\nif\\ \\[\\[\\ \\\\\\\"\\$comparison_method\\\\\\\"\\ \\=\\=\\ distance\\*\\ \\]\\]\\;\\ then\\\\n\\ \\ echo\\ \\\\\\\"Using\\ distance-based\\ comparison\\ with\\ threshold\\ \\$\\{distance_threshold\\}\\\\\\\"\\\\n\\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --engine\\=scmp-distance\\ --scmp-distance\\=\\$\\{distance_threshold\\}\\\\\\\"\\\\n\\ \\ COMPARISON_METHOD\\=\\\\\\\"\\$\\{COMPARISON_METHOD\\}-distance\\$\\{distance_threshold\\}\\\\\\\"\\\\nfi\\\\n\\\\nif\\ \\[\\[\\ \\\\\\\"\\$comparison_method\\\\\\\"\\ \\=\\=\\ \\*no-partialcredit\\ \\]\\]\\ \\|\\|\\ \\[\\[\\ \\\\\\\"\\$comparison_method\\\\\\\"\\ \\=\\=\\ distance\\*\\ \\]\\]\\;\\ then\\\\n\\ \\ echo\\ \\\\\\\"no\\ partial\\ credit\\ /\\ variant\\ decomposition\\ is\\ used\\\\\\\"\\\\n\\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --no-decompose\\ --no-leftshift\\\\\\\"\\\\n\\ \\ COMPARISON_METHOD\\=\\\\\\\"\\$\\{COMPARISON_METHOD\\}-nopartialcredit\\\\\\\"\\\\nelse\\\\n\\ \\ echo\\ \\\\\\\"using\\ partial\\ credit\\ via\\ variant\\ decomposition\\\\\\\"\\\\n\\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --decompose\\ --leftshift\\\\\\\"\\\\n\\ \\ COMPARISON_METHOD\\=\\\\\\\"\\$\\{COMPARISON_METHOD\\}-partialcredit\\\\\\\"\\\\nfi\\\\n\\\\nif\\ \\[\\[\\ \\\\\\\"\\$target_bed\\\\\\\"\\ \\!\\=\\ \\\\\\\"\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ \\#\\ make\\ sure\\ our\\ query\\ bed\\ file\\ also\\ has\\ chr\\ prefixes\\\\n\\ \\ if\\ \\$fixchr\\;\\ then\\\\n\\ \\ \\ \\ zcat\\ -f\\ \\$\\{target_bed_path\\}\\ \\|\\ perl\\ -pe\\ \\'s/\\^\\(\\[0-9XYM\\]\\)/chr\\$1/\\'\\ \\|\\ perl\\ -pe\\ \\'s/chrMT/chrM/\\'\\ \\\\u003e\\ target.bed\\\\n\\ \\ else\\\\n\\ \\ \\ \\ cp\\ -f\\ \\$\\{target_bed_path\\}\\ target.bed\\\\n\\ \\ fi\\\\n\\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ -T\\ target.bed\\\\\\\"\\\\n\\ \\ COMPARISON_METHOD\\=\\\\\\\"\\$\\{COMPARISON_METHOD\\}-targeted\\\\\\\"\\\\nfi\\\\n\\\\nif\\ \\ \\[\\[\\ \\\\\\\"\\$use_stratification\\\\\\\"\\ \\!\\=\\ \\\\\\\"none\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ \\ \\ if\\ \\[\\[\\ \\\\\\\"\\$reference\\\\\\\"\\ \\!\\=\\ \\\\\\\"hg19\\\\\\\"\\ \\]\\]\\ \\\\u0026\\\\u0026\\ \\[\\[\\ \\\\\\\"\\$reference\\\\\\\"\\ \\!\\=\\ \\\\\\\"hs37d5\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ \\ \\ \\ \\ \\ \\ echo\\ \\\\\\\"Stratification\\ regions\\ are\\ not\\ supported\\ on\\ reference\\ \\$reference\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ \\ exit\\ 1\\;\\\\n\\ \\ \\ \\ fi\\\\n\\ \\ \\ \\ strat\\=\\\\\\\"/opt/ga4gh-benchmarking-tools/resources/stratification-bed-files/ga4gh_\\$\\{use_stratification\\}.tsv\\\\\\\"\\\\n\\ \\ \\ \\ if\\ \\[\\[\\ -f\\ \\\\\\\"\\$strat\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ \\ \\ \\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --stratification\\ \\$\\{strat\\}\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ if\\ \\$fixchr\\;\\ then\\\\n\\ \\ \\ \\ \\ \\ \\ \\ \\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --stratification-fixchr\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ fi\\\\n\\ \\ \\ \\ else\\\\n\\ \\ \\ \\ \\ \\ \\ echo\\ \\\\\\\"Unknown\\ stratification\\ regions:\\ \\$\\{use_stratification\\}\\\\\\\"\\\\n\\ \\ \\ \\ \\ \\ \\ exit\\ 1\\\\n\\ \\ \\ \\ fi\\\\nelif\\ \\[\\[\\ \\\\\\\"\\$custom_stratification\\\\\\\"\\ \\!\\=\\ \\\\\\\"\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ mkdir\\ -p\\ \\`pwd\\`/custom_stratification\\\\n\\ \\ tar\\ xf\\ \\$custom_stratification_path\\ -C\\ \\`pwd\\`/custom_stratification\\ --no-same-permissions\\\\n\\ \\ TSVCOUNT\\=\\$\\(ls\\ -l\\ \\`pwd\\`/custom_stratification/\\*.tsv\\ \\|\\ wc\\ -l\\)\\\\n\\ \\ if\\ \\[\\[\\ \\$TSVCOUNT\\ \\!\\=\\ 1\\ \\]\\]\\;\\ then\\\\n\\ \\ \\ \\ echo\\ \\\\\\\"More\\ than\\ one\\ tsv\\ file\\ found\\ in\\ tar\\ file\\ for\\ custom_stratification.\\ Please\\ make\\ sure\\ only\\ one\\ such\\ file\\ is\\ in\\ the\\ archive.\\\\\\\"\\\\n\\ \\ \\ \\ exit\\ 1\\\\n\\ \\ fi\\\\n\\ \\ strat\\=\\$\\(ls\\ \\`pwd\\`/custom_stratification/\\*.tsv\\)\\\\n\\ \\ if\\ \\[\\[\\ -f\\ \\\\\\\"\\$strat\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ \\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --stratification\\ \\$\\{strat\\}\\\\\\\"\\\\n\\ \\ \\ \\ if\\ \\$fixchr\\;\\ then\\\\n\\ \\ \\ \\ \\ \\ \\ \\ HXX\\=\\\\\\\"\\$\\{HXX\\}\\ --stratification-fixchr\\\\\\\"\\\\n\\ \\ \\ \\ fi\\\\n\\ \\ else\\\\n\\ \\ \\ \\ \\ echo\\ \\\\\\\"Cannot\\ use\\ stratification\\ regions:\\ \\$\\{custom_stratification\\}\\\\\\\"\\\\n\\ \\ \\ \\ \\ exit\\ 1\\\\n\\ \\ fi\\\\nfi\\\\n\\\\n/opt/hap.py/bin/vcfcheck\\ \\$\\{truth_vcf_path\\}\\ --check-bcf-errors\\ 1\\\\n/opt/hap.py/bin/vcfcheck\\ \\$\\{query_vcf_path\\}\\ --check-bcf-errors\\ 1\\\\n\\\\nif\\ \\[\\[\\ \\\\\\\"\\$query_2_vcf\\\\\\\"\\ \\!\\=\\ \\\\\\\"\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ /opt/hap.py/bin/vcfcheck\\ \\$\\{query_2_vcf_path\\}\\ --check-bcf-errors\\ 1\\\\nfi\\\\n\\\\nHAPPY\\=\\\\\\\"/opt/hap.py/bin/hap.py\\\\\\\"\\\\nHAPPY_1\\=\\\\\\\"\\$\\{HAPPY\\}\\ \\$\\{truth_vcf_path\\}\\ \\$\\{query_vcf_path\\}\\ -o\\ results/result_1\\ \\$\\{HXX\\}\\\\\\\"\\\\nHAPPY_2\\=\\\\\\\"\\$\\{HAPPY\\}\\ \\$\\{truth_vcf_path\\}\\ \\$\\{query_2_vcf_path\\}\\ -o\\ results/result_2\\ \\$\\{HXX\\}\\\\\\\"\\\\n\\\\necho\\ \\\\\\\"\\$HAPPY_1\\\\\\\"\\\\n\\$HAPPY_1\\ 2\\\\u003e\\\\u00261\\ \\|\\ tee\\ happy.log\\\\n\\\\nSAFE_LABEL_1\\=\\$\\(echo\\ \\\\\\\"\\$\\{query_method\\}\\\\\\\"\\ \\|\\ sed\\ -e\\ \\'s/\\[\\^A-Za-z0-9\\\\\\\\.,\\]/-/g\\'\\)\\\\nSAFE_LABEL_M\\=\\$\\(echo\\ \\\\\\\"\\$\\{COMPARISON_METHOD\\}\\\\\\\"\\ \\|\\ sed\\ -e\\ \\'s/\\[\\^A-Za-z0-9\\\\\\\\.,\\]/-/g\\'\\)\\\\n\\\\nREPPY_INPUTS\\=\\\\\\\"\\$\\{SAFE_LABEL_1\\}_\\$\\{SAFE_LABEL_M\\}:results/result_1.roc.all.csv.gz\\\\\\\"\\\\nif\\ \\[\\[\\ \\\\\\\"\\$query_2_vcf\\\\\\\"\\ \\!\\=\\ \\\\\\\"\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ echo\\ \\\\\\\"\\$HAPPY_2\\\\\\\"\\\\n\\ \\ \\$HAPPY_2\\ 2\\\\u003e\\\\u00261\\ \\|\\ tee\\ happy.log\\\\n\\\\n\\ \\ SAFE_LABEL_2\\=\\$\\(echo\\ \\\\\\\"\\$\\{query_2_method\\}\\\\\\\"\\ \\|\\ sed\\ -e\\ \\'s/\\[\\^A-Za-z0-9\\\\\\\\.,\\]/-/g\\'\\)\\\\n\\ \\ REPPY_INPUTS\\=\\\\\\\"\\$\\{REPPY_INPUTS\\}\\ \\$\\{SAFE_LABEL_2\\}_\\$\\{SAFE_LABEL_M\\}:results/result_2.roc.all.csv.gz\\\\\\\"\\\\nfi\\\\n\\\\nREPPY\\=\\\\\\\"python\\ /opt/ga4gh-reporting/bin/rep.py\\ \\$REPPY_INPUTS\\ -o\\ output.html\\\\\\\"\\\\necho\\ \\\\\\\"\\$REPPY\\\\\\\"\\\\n\\$REPPY\\\\n\\\\n\\#\\ zip\\ detauiled\\ results\\\\ntar\\ czf\\ output.tar.gz\\ results\\\\n\\\\nemit\\ report_html\\ output.html\\\\nemit\\ happy_log\\ happy.log\\\\nemit\\ detailed_results\\ output.tar.gz\\\\n\\\"\\} | python -c 'import sys,json; print json.load(sys.stdin)[\"code\"]' \u003e /script.sh"]

# Create directory /work and set it to $HOME and CWD
RUN mkdir -p /work
ENV HOME="/work"
WORKDIR /work

# Set entry point to container
ENTRYPOINT ["/usr/bin/run"]

VOLUME /data
VOLUME /work
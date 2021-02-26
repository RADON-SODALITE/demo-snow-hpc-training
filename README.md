# demo-snow-cloud

## Service template

In this service template (**service.yml**), the following is created:

- OpenStack Security Group and Keypair
- OpenStack VM
- NiFi instance
- Data pipeline that moves the initial dataset (**dataset.tar.xz**) from S3 bucket to GridFTP server located in the HLRS HPC testbed 
- Execution of HPC job that extracts the dataset, performs test ML training on the dataset and produces the model (protobufs/PeakLens_original.pb)
- Data pipeline that moves the resulting model from HLRS GridFTP server into another S3 bucket  

### Prerequisites

In order to run the test service, the following packages are needed:

- openstack==0.52
- xOpera

Additionally, the following sister directories must exist:

```
$ tree -L 1
.
├── demo-snow-hpc-training <- this repository
├── iac-modules
└── S3toGridFTPpipeline

```

- **iac-modules**: `git clone https://github.com/RADON-SODALITE/iac-modules`
- **S3toGridFTPpipeline**: an extracted and merged CSAR of these service templates: [S3toGridFTPpipeline](https://github.com/RADON-SODALITE/radon-particles/blob/master/servicetemplates/radon.blueprints.examples/S3toGridFTPpipeline/ServiceTemplate.tosca) [gridFTPtoS3pipeline](https://github.com/RADON-SODALITE/radon-particles/blob/master/servicetemplates/radon.blueprints.examples/gridFTPtoS3pipeline/ServiceTemplate.tosca). Once extracted, the files in the `\_definitions` directory should be modified pointing to relative path for node and relationship types, e.g. 
    - `/nodetypes/radon.nodes.nifi/Nifi/files/stop/stop.yml -> ../nodetypes/radon.nodes.nifi/Nifi/files/stop/stop.yml`
    - `/relationshiptypes/radon.relationships.datapipeline/ConnectNifiLocal/files/connect.yml -> ../relationshiptypes/radon.relationships.datapipeline/ConnectNifiLocal/files/connect.yml`

### Deployment

To prepare needed node and relationship types, run:
```
$ make prepare
```

To deploy, firstly modify **inputs.yml** and then run:
```
$ make deploy
```
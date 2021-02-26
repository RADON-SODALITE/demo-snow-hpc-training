prepare:
	rm -f sodalite && rm -f radon && \
	ln -sf ../iac-modules sodalite && \
	ln -sf ../S3toGridFTPpipeline radon

deploy: prepare
	opera deploy -i inputs.yml service.yml

deploy-test: prepare
	opera deploy -i inputs.yml test_service.yml

clean:
	rm -rf .opera

clean-all:
	rm -rf .opera && sed -i 's/:.*/:/' inputs.yml
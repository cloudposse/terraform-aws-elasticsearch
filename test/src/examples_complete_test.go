package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-west-1.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	vpcCidr := terraform.Output(t, terraformOptions, "vpc_cidr")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "172.16.0.0/16", vpcCidr)

	// Run `terraform output` to get the value of an output variable
	privateSubnetCidrs := terraform.OutputList(t, terraformOptions, "private_subnet_cidrs")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, []string{"172.16.0.0/18", "172.16.64.0/18"}, privateSubnetCidrs)

	// Run `terraform output` to get the value of an output variable
	publicSubnetCidrs := terraform.OutputList(t, terraformOptions, "public_subnet_cidrs")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, []string{"172.16.128.0/18", "172.16.192.0/18"}, publicSubnetCidrs)

	// Run `terraform output` to get the value of an output variable
	domainHostname := terraform.Output(t, terraformOptions, "domain_hostname")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "es-test.testing.cloudposse.co", domainHostname)

	// Run `terraform output` to get the value of an output variable
	kibanaHostname := terraform.Output(t, terraformOptions, "kibana_hostname")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "kibana-es-test.testing.cloudposse.co", kibanaHostname)

	// Run `terraform output` to get the value of an output variable
	domainEndpoint := terraform.Output(t, terraformOptions, "domain_endpoint")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, domainEndpoint, "vpc-eg-test-es-test")
	assert.Contains(t, domainEndpoint, "us-west-1.es.amazonaws.com")

	// Run `terraform output` to get the value of an output variable
	kibanaEndpoint := terraform.Output(t, terraformOptions, "kibana_endpoint")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, kibanaEndpoint, "vpc-eg-test-es-test")
	assert.Contains(t, kibanaEndpoint, "us-west-1.es.amazonaws.com/_plugin/kibana")
}

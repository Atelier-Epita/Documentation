# Google Workspace

## Terraform

Terraform is used to automate the creation of google users
and ease the management of said users.
Terraform in itself can do way more and you can read about it [here](https://developer.hashicorp.com/terraform?product_intent=terraform).

## Configuration

### Required environment variables

- `AWS_ACCESS_KEY_ID`: the access key id for the s3 backend
- `AWS_SECRET_ACCESS_KEY`: the secret access key for the s3 backend

### Required files

- `key.json`: The credentials file for the google workspace service account.

## Usage

[Terraform repo](https://github.com/Atelier-Epita/infrastructure/tree/main/terraform/google)

We are using GoogleWorkspace's official provider so every informations
can be found in it's [documentation](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs).

Creation or modification of a user can be done by changing the
variables in the users.tfvars file, same for groups in the groups.tfvars file.

After modifying said files, using terraform will do the changes for you
but it is a good idea to do a plan before and check it toughtrully
to ensure everything is as expected.

Keep in mind that users and groups can still be created using google admin
and wont be visible in the .tfvars files.

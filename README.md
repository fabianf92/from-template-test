# Terraform Kickstart Template

This repository serves as a template to create a new Terraform GitHub repository that already includes all necessary GitHub workflows to deploy infrastructure with Terraform.

# Requirements

- Task (Taskfile) --> https://taskfile.dev/installation/
- Docker
- aws-cli (v2)
- precommit (optional)

# Contents

[1. Caller Taskfile and reusable Taskfiles](#taskfile)
<br>
[2. Syntax of config.yaml](#config)
<br>
[3. Reusable Workflows](#workflow)
<br>
[4. Migrate to new config.yaml with workflows](#migrate)
<br>
[5. Pre-Commit](#precommit)

# <a id="taskfile">1. Caller Taskfile and reusable Taskfiles</a>

> **_REQUIREMENTS:_**
<br> - Task (Taskfile) --> https://taskfile.dev/installation/
<br> - Docker
<br> - aws-cli (v2) --> You must be logged into an account of the AWS BioNTechSE

Copy the content from [Caller Taskfile template](https://github.com/biontechse/reusable-taskfile/blob/main/CallerTaskfile.template.yaml) and paste it into the `Taskfile.yaml` in the root of your GitHub repository (In this kickstart template there is already a Caller Taskfile).

Now you can run this command:
```bash
# 1. This command will download all reusable Taskfiles into your GitHub repository (./taskfiles/) from the S3 bucket.
$ task init

🔧 [TASK:] check-yq-version

🔔 [INFO:] yq is already installed in version yq (https://github.com/mikefarah/yq/) version v4.34.2

🔧 [TASK:] check-taskfile-version

✅ [SUCCESS:] Taskfile version is set in config.yaml.

🔧 [TASK:] check-task-version

🔔 [INFO:] task is already installed in version Task version: v3.27.1 (h1:cftsoOqUo7/pCdtO7fDa4HreXKDvbrRhfhhha8bH9xc=)

🔧 [TASK:] check-aws-login

✅ [SUCCESS:] You are logged in to AWS BioNTechSE organization.

🔧 [TASK:] download-taskfiles

🔔 [INFO:] Downloading version 7mEJTpKwyrSc09yCI.__8MN89XPqAxff of reusable Taskfiles from S3

✅ [SUCCESS:] Downloaded reusable Taskfiles to /home/nik/projects/biontech/BAT/terraform-kickstart-template/taskfiles

# 2. This task shows you all available tasks
$ task
task: [default] task --list-all

🔧 [TASK:] default

task: Available tasks for this project:
* default:                                Show this help message      (aliases: help)
* init:                                   Initialize working environment by downloading reusable Taskfile
* aws:liquibase:apply:changeset:          Apply Liquibase changeset.
* aws:liquibase:rollback:changeset:       Rollback Liquibase changeset.
* cfn:check:                              Check Cloudformation files
* cfn:cleanup:                            Cleanup cloudformation environment
* cfn:lint:                               Run cfn-lint for specific project or directory
* lw:init:                                Initialize working environment by downloading custom policies
* lw:scan:                                Scan Terraform or Cloudformation code via Lacework
* tf:apply:                               Run Terraform {{.TERRAFORM_COMMAND}} for selected project.
* tf:check:                               Run Terraform checks, using terraform fmt, tflint, gitleaks, lacework scan and terraform validate.
* tf:checkov:                             Run Terraform checkov.
* tf:deduce-config-tf-vars:               Deduce necessary values from config.yaml for Terraform projects
* tf:destroy:                             Run Terraform {{.TERRAFORM_COMMAND}} for selected project.
* tf:fmt:                                 Run Terraform fmt.
* tf:gitleaks:                            Run gitleaks.
* tf:lint:                                Run Terraform tflint.
* tf:plan:                                Run Terraform {{.TERRAFORM_COMMAND}} for selected project.
* tf:up:                                  Login to Docker registry and install Terraform
* tf:validate:                            Run Terraform validate for all projects.
* tf:workspace:destroy:                   Run terraform workspace destroy for selected project and current branch name as workspace.
* tf:workspace:init:                      Run Terraform init and create/select workspace for selected project with current branch name.
$ task

# 3. Initialize the Terraform environment
# You will be asked if you want to create an SSH key. This is necessary to access the internal GitHub repositories within the BioNTechSE organization.
$ task tf:up

🔧 [TASK:] tf:deduce-config-tf-vars

account=857742961209
account_key=dso-dev02
aws_region=eu-central-1
dev_environment=dev
environment=dev
environments=[dev]
tf_backend_bucket=tf-backend-terraform-kickstart-template-dev
tf_backend_role=arn:aws:iam::857742961209:role/gh-tf-backend-terraform-kickstart-template-dev
tf_local_backend=false
tf_oidc_role=arn:aws:iam::857742961209:role/gh-oidc-terraform-kickstart-template-deployment_role
tf_state_file=tf-backend-terraform-kickstart-template-kick_start-dev.tfstate
tf_version=1.4.6
tf_working_dir=infrastructure/example

🔧 [TASK:] check-aws-login

✅ [SUCCESS:] You are logged in to AWS BioNTechSE organization.
Untagged: terraform-module-checks-tf-installed:latest
Deleted: sha256:b511d87a3b8d23bab9e328f00c782031eb889882f6a4587f39a660b6b1decf56
Deleted: sha256:0c415b76868e8c6b3e0a1fa4740e4f5b31ea611aec3f7b1864714247e7fbf6c7
🔔 [INFO:] Create Docker container with Terraform v.1.4.6
SSH key is already authenticated
Install Terraform version 1.4.6
Log out of GitHub via gh cli
not logged in to any hosts
✅ [SUCCESS:] Successfully created new Docker container with Terraform v.1.4.6


# 4. Finally you can run some Terraform checks

$ task tf:check disable_lw_scan=true

🔧 [TASK:] tf:deduce-config-tf-vars

account=857742961209
account_key=dso-dev02
aws_region=eu-central-1
dev_environment=dev
environment=dev
environments=[dev]
tf_backend_bucket=tf-backend-terraform-kickstart-template-dev
tf_backend_role=arn:aws:iam::857742961209:role/gh-tf-backend-terraform-kickstart-template-dev
tf_local_backend=false
tf_oidc_role=arn:aws:iam::857742961209:role/gh-oidc-terraform-kickstart-template-deployment_role
tf_state_file=tf-backend-terraform-kickstart-template-kick_start-dev.tfstate
tf_version=1.4.6
tf_working_dir=infrastructure/example


🔧 [TASK:] check-aws-login

✅ [SUCCESS:] You are logged in to AWS BioNTechSE organization.

🔧 [TASK:] TERRAFORM FMT

🔔 [INFO:] Run TERRAFORM FMT terraform for project kick_start. Please wait!


🔧 [TASK:] TERRAFORM LINT

🔔 [INFO:] Run TERRAFORM LINT terraform for project kick_start. Please wait!

TFLint version 0.46.1
+ ruleset.terraform (0.2.2-bundled)

🔧 [TASK:] GITLEAKS


    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

7:01AM INF 126 commits scanned.
7:01AM INF scan completed in 110ms
7:01AM INF no leaks found

🔧 [TASK:] CHECKOV

🔔 [INFO:] Run CHECKOV terraform for project kick_start. Please wait!

terraform scan results:

Passed checks: 2, Failed checks: 0, Skipped checks: 0

🔧 [TASK:] TERRAFORM VALIDATE

🔔 [INFO:] Run TERRAFORM VALIDATE terraform for project kick_start. Please wait!

Initializing modules...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v4.36.1

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
Success! The configuration is valid.

```

More info about tasks:

- aws: [Documentation](https://github.com/biontechse/reusable-taskfile/blob/main/taskfiles/aws/README.md)
- cloudformation: [Documentation](https://github.com/biontechse/reusable-taskfile/blob/main/taskfiles/cloudformation/README.md)
- terraform: [Documentation](https://github.com/biontechse/reusable-taskfile/blob/main/taskfiles/terraform/README.md)
- lacework: [Documentation](https://github.com/biontechse/reusable-taskfile/blob/main/taskfiles/lacework/README.md)

&uarr; [back to top](#top)

# <a id="config">2. Syntax of `config.yaml`</a>

This file was introduced to provide a central configuration file for the GitHub repository.
Among other things, this is used to configure the environments, OIDC connection, workflow settings or the cloud blocks.

- Find the schema of the config.yaml [here](https://github.com/biontechse/reusable-workflows/blob/main/config-validator/config_schema.json).

## Root level elements of the config.yaml


## 2.1. taskfile (mandatory)

Previously taskfile version is passed via `.env` file, with the new config.yaml syntax user can define the taskfile version in this section. Find the Taskfile hash [in the S3 Object Version](https://github.com/biontechse/reusable-taskfile/releases).

```
taskfile:
  version: mfkZ5EnK6YE3SXLnHoP1_aVupxTIP13d
```
## 2.2. environments (mandatory)

Definition of the environments. E.g.: dev, int, val and prod. Users are allow to use any meaningful names for their environments but make sure to mark what is their `development` environment by specifying `dev_environment: true` as below. Only one environment can be the `dev_environment`, all others are set to false by default.

Example usage:

```
environments:
  dev:
    dev_environment: true
    aws: dso-dev02
  int:
    aws: dso-dev03
  val:
    aws: dso-dev04
  prd:
    aws: dso-dev05
```
`Fyi:`
According the SOP documentation (SOP-080-014-V07: 4.4.1 IT environment concept) there are currently four environments (dev, int, val and prod) with GxP relevance and criticality for managed IT infrastructure components.
With regard to the simplicity we use only one of these four environments: `dev` in this kickstart template.

Please read the official GitHub documentation about using environments:
https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment

## 2.3. aws/azure (mandatory)

This can be either `aws` or `azure`. Here user can describe specific environment. For the `aws` there are 2 sections.

- `accounts`:
  Define accounts attributes.
- `iam_policies`:
  Define IAM policies that can be refer in the accounts section.

Example usage:

```
aws:
  accounts:
    dso-dev02:
      account_id: "857742961209"
      region: eu-central-1
      iam_roles:
        deployment_role:
          iam_policies:
            - deployment_policy_1
            - deployment_policy_2
          refs:
            - ref:refs/heads/main
        testing_role:
          iam_policies:
            - testing_policy_1
          refs:
            - ref:refs/heads/main
            - ref:refs/heads/feature/*
    dso-dev03:
      account_id: "228819980041"
      region: eu-central-1
      iam_roles:
        deployment_role:
          iam_policies:
            - deployment_policy_1
            - deployment_policy_2
          refs:
            - ref:refs/heads/main
        testing_role:
          iam_policies:
            - testing_policy_1
            - testing_policy_2
          refs:
            - ref:refs/heads/main
            - ref:refs/heads/feature/*
  iam_policies:
    deployment_policy_1:
      {
        "Version": "2012-10-17",
        "Statement":
          [
            {
              "Effect": "Allow",
              "Action": ["s3:*"],
              "Resource": "arn:aws:s3:::terraform-reusable-test-*",
            },
          ],
      }
    testing_policy_1:
      {
        "Version": "2012-10-17",
        "Statement":
          [
            {
              "Effect": "Allow",
              "Action": ["sns:*"],
              "Resource": "arn:aws:sns:::sns-notification-*",
            },
          ],
      }
```

## 2.4. terraform (mandatory)

User can define the terraform configurations here. There are 3 sections.

- `version`: Terraform version. This can be override in the project section.
- `modules`: User defined terraform modules that specifics for the repository. If you have a reusable module consider to move in to a different repository and refer that directly in the project. `tf:check` task will be run for the modules that user has defined here. For ex: If you have a directory called `shared_modules` that has 3 modules inside; just specify the `- ./shared-modules/*` it will recursively checks the those 3 modules.
- `projects`: Defines the project specific terraform configurations. If repo has different directories for the different environments, user can define those directories as different projects and map to accounts in github workflows.
- `compliance_standard`: <cis,gxp,hipaa> You can set the compliance standard in the `terraform` or specifically for each project in the `project` level.
- `terratest` sub-section is optional in the project level

Example usage:

```
terraform:
  compliance_standard: cis
  version: 1.3.3
  modules:
    - ./shared-modules/*
  projects:
    dev_project:
      version: 1.3.4 # terraform version -> overwrites terraform.version
      dir: ./terraform/dev # execution path of terraform
      aws_iam_role: deployment_role # linked to aws.<account-name>.iam_roles.<name>
      tf_local_backend: true
      terratest: &main_terratest
        cpu: 4
        aws_iam_role: testing_role
        parallel: 10
        timeout: 360m
    int_project:
      dir: ./terraform/int
      aws_iam_role: testing_role
      terratest:
        <<: *main_terratest
        aws_iam_role: testing_role

```

### Use a remote backend

`tf_local_backend: false` for a specific project; remote backend will be created in the environment that going to get deployed. Each project will have separate state file. Remote backend(s3 bucket) will be shared for all the project in the specific environment.

- S3-bucket name pattern: `tf-backend-$repo_name-$environment`
- State file pattern: `tf-backend-$repo_name-$project_key-$environment.tfstate`
- Backend IAM role pattern: `arn:aws:iam::$account_id:role/gh-tf-backend-$repo_name-$environment`

## 2.5. liquibase (optional)

Liquibase configurations. Find more about the liquibase tasks and configurations [here](https://github.com/biontechse/reusable-taskfile/tree/main/docs/aws).

```
  liquibase:
    dso-dev02: # Map to the environments; account ids will be deduced.
      lambda_name: schema_management_liquibase-demo
      changeset_bucket: liquibase-schema-management-20230406080428383900000001
      databases:
        db1:
          secret_arn: arn:aws:secretsmanager:eu-central-1:228819980041:secret:mlops-test-db-EQgSpY
        db2:
          secret_arn: arn:aws:secretsmanager:eu-central-1:xxxxxxxxx:secret:cde-test-db-EQgSpY
        redshift_serverless:
          secret_arn: arn:aws:secretsmanager:eu-central-1:xxxxxxxxx:secret:xyz-test-db-EQgSpY

```

## 2.6. cloudblock (optional)

This is just a BAT internal key!

```
cloudblock:
  version: v0.1.0
```
&uarr; [back to top](#top)

# <a id="workflow">3. Reusable Workflows</a>

> **_IMPORTANT:_** We're using the `Scaled Trunked Development` Git strategy as described [here](https://bnt-digital.atlassian.net/l/cp/XVX2L6f2)

This GitHub repository uses [reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows). This has the advantage that we reduce the whole CICD logic to four files:

- boostrap.yaml
- push.yaml
- pull-request.yaml
- release.yaml
## 3.1. boostrap.yaml

> **_IMPORTANT:_** This workflow should be executed first before all others

This workflow has a manual trigger, that means it can only run if the user explicitly starts it.
The workflow is there to create the Terraform backends as well as all OIDC connections described in the central config.yaml.
Just configure the file as described and the pipeline deduces all revelant data - just relax and sit back :)

## 3.2. push.yaml

This workflow only runs on feature/_ and bugfix/_ branches and triggers the CI pipeline. The following jobs are executed:

- terratest (optional)
- terraform format
- terraform lint
- GitHub Leaks
- checkov
- Lacework scans
- terraform validate

## 3.3. pull-request.yaml

Pull-request always run on dev environment(`dev_environment: true`). This workflow will only be executed on Pull Request events on the main branch. The following jobs are executed:

- same CI jobs as above (push.yaml)
- terraform plan on the dev environment

## 3.4. release.yaml

This workflow will only be executed on Push events on the main branch. The following jobs are executed:

- same CI jobs as above (push.yaml)
- terraform plan AND apply on all environemnts


### 3.4.1. Single environment and pass terraform variable files (tfvars)

The config.yaml does not have an attribute to pass the tfvars file. This is intentional. Users can pass specific tfvars file in the workflow (if it's supported). For example `tf-cd-single-environment.yaml` users can pass the tfvars file as below with `tf_var_file` attribute. File should be exists in the project directory. In the below setup workflow search the file in root directory of `custom_project_key1` project.

```
  deploy_to_dev:
    uses: biontechse/reusable-workflows/.github/workflows/tf-cd-single-environment.yaml@<version>
    secrets: inherit
    with:
      tf_project: custom_project_key1
      tf_env: dev
      tf_var_file: dev.tfvars
```

### 3.4.2. Multi environments deployment

We have removed the multi-env deployment workflow. There are 2 ways users can define the multi environments deployment.

- Repeat n time `tf-cd-single-environment.yaml` workflow

```
jobs:
  deploy_to_dev:
    uses: biontechse/reusable-workflows/.github/workflows/tf-cd-single-environment.yaml@<version>
    secrets: inherit
    with:
      tf_project: your-project-key
      tf_env: dev
      tf_var_file: dev.tfvars

  deploy_to_int:
    uses: biontechse/reusable-workflows/.github/workflows/tf-cd-single-environment.yaml@<version>
    secrets: inherit
    with:
      tf_project: your-project-key
      tf_env: int
      tf_var_file: int.tfvars
```

- Use `matrix` to pass the different enviornments.

```
jobs:
  multi-env-deployment:
    strategy:
      matrix:
        include:
          - tf_project: your-project-key
            tf_env: dev
            tf_var_file: dev.tfvars
          - tf_project: your-project-key
            tf_env: int
            tf_var_file: int.tfvars

    uses: biontechse/reusable-workflows/.github/workflows/tf-cd-single-environment.yaml@<version>
    secrets: inherit
    with:
      tf_project: ${{ matrix.tf_project }}
      tf_env: ${{ matrix.tf_env }}
      tf_var_file: ${{ matrix.tf_var_file }}
```

&uarr; [back to top](#top)

# <a id="migrate">4. Migrate to new config.yaml with workflows</a>

- Create a development/feature branch.
- Adapt config.yaml to the new version.
- Use the latest Taskfile version (https://github.com/biontechse/reusable-taskfile/releases).
- Use the latest workflow version (https://github.com/biontechse/reusable-workflows/releases).
- We haven't change the backend bucket name (`tf-backend-$repo_name-$environment`) nor the stackname(`tf-oidc-$repo_name-$environment`) that create the backend.
- There will be a project specific statefile `tf-backend-$repo_name-$project_key-$environment.tfstate`. If the existing state file is not in this format please do below steps.

## 4.1. Steps to rename old statefile to new format(dev environment).

- Take a backup of existing statefile.
- Rename the existing statefile to the new format manually in the bucket.
- Push the changes to the branch.
- Create a pull-request.
- This should trigger the terraform init in the pull-request workflow. Make sure it uses the renamed statefile. Terraform plan should show no changes.

## 4.2. Steps to rename old statefile to new format(int,val,prd environment).

- Take a backup of existing statefile.
- Rename the existing statefile to the new format manually in the bucket.
- Merge the changes to the main branch.
- IMPORTANT: Please check the `terraform plan` before to make sure its does use the renamed statefile then move to the applying the changes.

More info you can find in the [reusabe-workflows](https://github.com/biontechse/reusable-workflows) repository.

&uarr; [back to top](#top)

# <a id="precommit">5. Pre-Commit</a>

We use Precommit in combination with Docker.
This has the advantage that the used plugins/tools do not have to be installed locally.
Initialize precommit locally by executing this command:

```bash
$ pre-commit install
```

&uarr; [back to top](#top)

---

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

data "terraform_remote_state" "bootstrap" {
  backend = "gcs"
  config = {
    bucket = "gcs-prj-b-seed-tfstate-lce"
    prefix = "0-bootstrap/"
  }
}

data "terraform_remote_state" "org" {
  backend = "gcs"
  config = {
    bucket = "gcs-prj-b-seed-tfstate-lce"
    prefix = "1-org/"
  }
}

data "terraform_remote_state" "env" {
  backend = "gcs"
  config = {
    bucket = "gcs-prj-b-seed-tfstate-lce"
    prefix = "2-env/dev/"
  }
}

data "terraform_remote_state" "folders" {
  backend = "gcs"
  config = {
    bucket = "gcs-prj-b-seed-tfstate-lce"
    prefix = "1-org/folders/"
  }
}

data "terraform_remote_state" "networks" {
  backend = "gcs"
  config = {
    bucket = "gcs-prj-b-seed-tfstate-lce"
    prefix = "3-networks/dev/"
  }
}

data "terraform_remote_state" "projects" {
  backend = "gcs"
  config = {
    bucket = "gcs-prj-b-seed-tfstate-lce"
    prefix = "4-projects/dev/"
  }
}

data "terraform_remote_state" "app-infra" {
  backend = "gcs"
  config = {
    bucket = "gcs-prj-b-seed-tfstate-lce"
    prefix = "5-app-infra/dev/"
  }
}
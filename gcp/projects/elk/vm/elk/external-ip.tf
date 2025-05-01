resource "local_file" "external_ip" {
  content  = module.elk-vm.vm-external-ip
  filename = "external-ip.txt"
}
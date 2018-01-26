#!/bin/bash
function StartPacker {
    local params="$@";
    local coreos_release="stable";
    local coreos_version="1576.5.0";
    local coreos_url_digests="http://${coreos_release}.release.core-os.net/amd64-usr/${coreos_version}/coreos_production_iso_image.iso.DIGESTS";
    local coreos_iso_checksum_type="SHA512";
    local coreos_iso_checksum=$(wget -qO- "${coreos_url_digests}" | grep "coreos_production_iso_image.iso" | awk '{ print length, $1 | "sort -rg"}' | awk 'NR == 1 { print $2 }');
    local working_directory=".";
    local build_path="./packer-builds/coreos-vagrant-packer";
    local provisioner_path="./pre-provision";
    local template_path="./packer-builds/coreos-vagrant-packer/packer-template";
    local template_file="${template_path}/coreos-vagrant-template-min.json";
    __run_packer() {
        # FONT: https://www.packer.io/docs/templates/user-variables.html#from-a-file
        packer "$@" \
			-var-file="${template_path}/vars-global.json" \
			-var-file="${template_path}/vars-coreos.json" \
			-var-file="${template_path}/vars-vagrant.json" \
            -var-file="${template_path}/vars-custom-variables.json" \
            -var "os_release=${coreos_release}" \
            -var "os_version=${coreos_version}" \
            -var "os_iso_checksum_type=${coreos_iso_checksum_type}" \
            -var "os_iso_checksum=${coreos_iso_checksum}" \
            -var "global_working_directory=${working_directory}" \
            -var "global_build_path=${build_path}" \
            -var "global_provisioner_path=${provisioner_path}" \
            "${template_file}";
    }
    case $params in
        validate) { __run_packer $params; };;
        inspect)  { packer inspect "${template_file}"; };;
        *build*)  { __run_packer $params; };;
        *)        { packer $params; };;
    esac
}
StartPacker "$@";
exit 0;

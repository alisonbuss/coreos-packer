#!/bin/bash
function StartPacker {
    local params="$@";
    local coreos_release="stable";
    local coreos_version="current";
    local coreos_url_digests="http://${coreos_release}.release.core-os.net/amd64-usr/${coreos_version}/coreos_production_iso_image.iso.DIGESTS";
    local coreos_iso_checksum_type="SHA512";
    local coreos_iso_checksum=$(wget -qO- "${coreos_url_digests}" | grep "coreos_production_iso_image.iso" | awk '{ print length, $1 | "sort -rg"}' | awk 'NR == 1 { print $2 }');
    local build_path="./packer-builds/coreos-vagrant-packer";
    local template_path="./packer-builds/coreos-vagrant-packer/packer-template";
    __run_packer() {
        packer "$@" \
			-var-file="${template_path}/vars-global.json" \
			-var-file="${template_path}/vars-coreos.json" \
			-var-file="${template_path}/vars-machine-large.json" \
			-var-file="${template_path}/vars-vagrant.json" \
            -var "coreos_release=${coreos_release}" \
            -var "coreos_version=${coreos_version}" \
            -var "coreos_iso_checksum_type=${coreos_iso_checksum_type}" \
            -var "coreos_iso_checksum=${coreos_iso_checksum}" \
            -var "global_build_path=${build_path}" \
            -var-file="${template_path}/vars-override-variables.json" \
            "${template_path}/coreos-vagrant-template-min.json";
    }
    case $params in
        validate) { __run_packer validate; };;
        build)    { __run_packer build;    };;
        *)        { packer "$@";           };;
    esac
}
StartPacker "$@";
exit 0;

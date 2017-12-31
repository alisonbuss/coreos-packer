#!/bin/bash
function StartPacker {
    local params="$@";
    local coreos_release="alpha";
    local coreos_version="1632.0.0";
    local coreos_url_digests="http://${coreos_release}.release.core-os.net/amd64-usr/${coreos_version}/coreos_production_iso_image.iso.DIGESTS";
    local coreos_iso_checksum_type="SHA512";
    local coreos_iso_checksum=$(wget -qO- "${coreos_url_digests}" | grep "coreos_production_iso_image.iso" | awk '{ print length, $1 | "sort -rg"}' | awk 'NR == 1 { print $2 }');
    local build_path="./packer-builds/coreos-vagrant-packer";
    local template_path="./packer-builds/coreos-vagrant-packer/packer-template";
    local template_file="${template_path}/coreos-vagrant-template-min.json";
    __run_packer() {
        packer "$@" \
			-var-file="${template_path}/vars-global.json" \
			-var-file="${template_path}/vars-coreos.json" \
			-var-file="${template_path}/vars-machine-large.json" \
			-var-file="${template_path}/vars-vagrant.json" \
            -var-file="${template_path}/vars-custom-variables.json" \
            -var "coreos_release=${coreos_release}" \
            -var "coreos_version=${coreos_version}" \
            -var "coreos_iso_checksum_type=${coreos_iso_checksum_type}" \
            -var "coreos_iso_checksum=${coreos_iso_checksum}" \
            -var "global_build_path=${build_path}" \
            "${template_file}";
    }
    case $params in
        validate) { __run_packer "${params}"; };;
        inspect)  { packer inspect "${template_file}"; };;
        build)    { __run_packer "${params}"; };;
        *)        { packer "${params}"; };;
    esac
}
StartPacker "$@";
exit 0;

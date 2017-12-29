#!/bin/bash
function StartPacker {
    local params="$@";
    local coreos_release="stable";
    local coreos_version="current";
    local coreos_url_iso="http://${coreos_release}.release.core-os.net/amd64-usr/${coreos_version}/coreos_production_iso_image.iso";
    local coreos_url_digests="${coreos_url_iso}.DIGESTS";
    local coreos_iso_checksum_type="SHA512";
    local coreos_iso_checksum=$(wget -qO- "${coreos_url_digests}" | grep "coreos_production_iso_image.iso" | awk '{ print length, $1 | "sort -rg"}' | awk 'NR == 1 { print $2 }');
    local package_working_directory="/mnt/sda2/git-repositories/public/coreos-packer/packages/coreos-aws-packer";
    local package_template_directory="/mnt/sda2/git-repositories/public/coreos-packer/packages/coreos-aws-packer/packer-template";
    __run_packer() {
        packer "$@" \
			-var-file="${package_template_directory}/vars-global.json" \
			-var-file="${package_template_directory}/vars-coreos.json" \
			-var-file="${package_template_directory}/vars-aws.json" \
            -var "release=${coreos_release}" \
            -var "version=${coreos_version}" \
            -var "iso_checksum_type=${coreos_iso_checksum_type}" \
            -var "iso_checksum=${coreos_iso_checksum}" \
            -var "build_path=${package_working_directory}" \
            -var-file="${package_template_directory}/vars-override-variables.json" \
            "${package_template_directory}/coreos-aws-template-min.json";
    }
    case $params in
        validate) { __run_packer validate; };;
        build)    { __run_packer build; };;
        *)        { packer "$@"; };;
    esac
}
StartPacker "$@";
exit 0;

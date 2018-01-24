#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script for key generation and TLS/SSL certificates.
# @fonts: https://github.com/cloudflare/cfssl
#         https://blog.cloudflare.com/introducing-cfssl/
#         https://technedigitale.com/archives/639
#         https://medium.com/@vrmvrm/setup-cloudflare-cfssl-with-ocsp-responder-aba44b4134e6
# @example:
#       bash compile-cfssl-certificates.sh \
#   		              --source-file="" \
#   		              --output-file="";
#-------------------------------------------------------------#

# @fonts: https://www.digitalocean.com/community/tutorials/using-grep-regular-expressions-to-search-for-text-patterns-in-linux
# @example:
#    $ util.getParameterValue "(--param3=|-p3=)" "$@"
function util.getParameterValue(){
    local exp=$1;
    local params=("$@");
    local valueEnd="";
    for value in "${params[@]:1:$#}"; do
        if grep -E -q "${exp}" <<< "${value}"; then
            valueEnd="${value#*=}";
            break;
        fi        
    done
    echo $valueEnd;
}

# @descr: Main function of the script, it runs automatically on the script call.
# @param: 
#    $@ | array: (*)
function StartCompilation {
    local param1=$(util.getParameterValue "(--param-01=)" "$@"); 
    local param2=$(util.getParameterValue "(--param-02=)" "$@"); 

    echo -e "\nStarting script execution [compile-cfssl-certificates.sh]";









    
    
 

} 

# @descr: Call of execution of the script's main function.
StartCompilation "$@";

# @descr: Finishing the script!!! :P
exit 0;
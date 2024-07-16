
function drun() {
    if [ -z "$1" ]; then
        echo "Usage: run_in_container <container_name> [command...]"
        return 1
    fi
    
    container_name=$1
    shift
    
    if [ $# -eq 0 ]; then
        command="bash"
    else
        command="$@"
    fi
    
    docker ps -qf "name=${container_name}" | xargs -o -I {} docker exec -it {} $command
}

function aws_profile() {
    if [ -z "$1" ]; then
        echo "Usage: aws_profile <name>"
        echo "Available profiles:"
        aws configure list-profiles
        return 1
    fi
    
    profile=$1
    export AWS_PROFILE="$profile"
}

function kube_run() {
    eval "kubectl run --quiet -i --rm --tty kube-run-${RANDOM} \
      --image=$1 --restart=Never -- ${@:2}"
}

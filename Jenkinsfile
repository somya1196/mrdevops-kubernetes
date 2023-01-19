node{
    stage ('Git checkout'){
        git 'https://github.com/somya1196/mrdevops-kubernetes.git'
    }
    
    stage ('Sending Dockerfile to ansible'){
        sshagent(['ansible']) {
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.37.202'
        sh 'scp /var/lib/jenkins/workspace/demo-project/* ubuntu@172.31.37.202:/home/ubuntu'
       }
    }
    
    stage ('Building and tagging image') {
        sshagent(['ansible']) {
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.37.202 cd /home/ubuntu'
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.37.202 docker build -t somya1196/somdevops .'
        }
    }
    
    stage ('Pushing Docker image to DockerHub') {
        sshagent(['ansible']) {
            withCredentials([string(credentialsId: 'dockerpwd', variable: 'docker')]) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.37.202 docker login -u somya1196 -p ${docker}"
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.37.202 docker image push somya1196/somdevops '
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.37.202 docker rmi somya1196/somdevops'
           }
        }
    }
    
    stage ('Copying file form jenkins to k8s server') {
        sshagent(['k8s']) {
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.34.160'
        sh 'scp /var/lib/jenkins/workspace/demo-project/* ubuntu@172.31.34.160:/home/ubuntu'
        }
    }
    
    stage ('K8s Deployment using Ansible') {
        sshagent(['ansible']) {
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.37.202 cd /home/ubuntu'
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.37.202 ansible-playbook ansible.yml'
      }
    }
    
}

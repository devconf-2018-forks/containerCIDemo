
podName = 'myslave'
STABLE_LABEL = "latest"

properties(
        [
                parameters(
                        [
                                string(name: 'COMPONENT1_TAG',
                                        defaultValue: STABLE_LABEL,
                                        description: 'Tag for component1 image'
                                ),
                                string(name: 'COMPONENT2_TAG',
                                        defaultValue: STABLE_LABEL,
                                        description: 'Tag for component2 image'
                                ),
                                string(name: 'DOCKER_REPO_URL',
                                        defaultValue: '172.30.254.79:5000',
                                        description: 'Docker repo url for Openshift instance'
                                ),
                                string(name: 'OPENSHIFT_NAMESPACE',
                                        defaultValue: 'continuous-infra-devel',
                                        description: 'Project namespace for Openshift operations',
                                ),
                                string(name: 'OPENSHIFT_SERVICE_ACCOUNT',
                                        defaultValue: 'devel-jenkins',
                                        description: 'Service Account for Openshift operations',
                                ),
                        ]
                ),
        ]
)

podTemplate(name: podName,
        label: podName,
        cloud: 'openshift',
        serviceAccount: params.OPENSHIFT_SERVICE_ACCOUNT,
        idleMinutes: 0,
        namespace: params.OPENSHIFT_NAMESPACE,

        containers: [
                // This adds the custom slave container to the pod. Must be first with name 'jnlp'
                containerTemplate(name: 'jnlp',
                        image: "openshift/jenkins-slave-base-centos7",
                        ttyEnabled: false,
                        args: '${computer.jnlpmac} ${computer.name}',
                        command: '',
                        workingDir: '/workDir'),
                // This adds the component1 container to the pod.
                containerTemplate(name: 'component1',
                        alwaysPullImage: true,
                        image: params.DOCKER_REPO_URL + '/' + params.OPENSHIFT_NAMESPACE
                                + '/component1:' + params.COMPONENT1_TAG,
                        ttyEnabled: true,
                        command: 'cat',
                        privileged: false,
                        workingDir: '/workDir'),
                // This adds the component2 container to the pod.
                containerTemplate(name: 'component2',
                        alwaysPullImage: true,
                        image: params.DOCKER_REPO_URL + '/' + params.OPENSHIFT_NAMESPACE
                                + '/component2:' + params.COMPONENT2_TAG,
                        ttyEnabled: true,
                        command: 'cat',
                        privileged: false,
                        workingDir: '/workDir'),
        ],
        volumes: [])
        {
            node(podName) {
                container('component1') {
                    sh 'echo $CONTAINERNAME'
                }
                container('component2') {
                    sh 'echo $CONTAINERNAME'
                }
            }
        }

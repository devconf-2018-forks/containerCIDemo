
podName = 'myslave'

properties(
        [
                parameters(
                        [
                                string(defaultValue: 'stable', description: 'Tag for component1 image', name: 'COMPONENT1_TAG'),
                                string(defaultValue: 'stable', description: 'Tag for component2 image', name: 'COMPONENT2_TAG'),
                                string(defaultValue: '172.30.1.1:5000', description: 'Docker repo url for Openshift instance', name: 'DOCKER_REPO_URL'),
                                string(defaultValue: 'continuous-infra', description: 'Project namespace for Openshift operations', name: 'OPENSHIFT_NAMESPACE'),
                                string(defaultValue: 'jenkins', description: 'Service Account for Openshift operations', name: 'OPENSHIFT_SERVICE_ACCOUNT'),
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
                        image: "jenkins/jnlp-slave:3.10-1-alpine",
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
                        privileged: true,
                        workingDir: '/workDir'),
                // This adds the component2 container to the pod.
                containerTemplate(name: 'component2',
                        alwaysPullImage: true,
                        image: params.DOCKER_REPO_URL + '/' + params.OPENSHIFT_NAMESPACE
                                + '/component2:' + params.COMPONENT2_TAG,
                        ttyEnabled: true,
                        command: 'cat',
                        privileged: true,
                        workingDir: '/workDir'),
        ],
        volumes: [])
        {
            node(podName) {
            }
        }

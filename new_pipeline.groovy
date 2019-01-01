def pipelineName = 'example'
pipelineJob(pipelineName) {
    definition {
        cps {
            script(readFileFromWorkspace('Jenkinsfile'))
            sandbox()
        }
    }
}
queue(pipelineName)

## AEG Docker Template

## Summary:

AEG has decided to standardize for standard websites the use of Docker, Jenkins for the CI/CD pipeline, GitHub for code repositories, Slack for communication, Microsoft Azure of the cloud provider, Alpine as the base OS for containers, Nginx as the web server, and PHP as the preferred coding language.  This repo will hold the latest code that can be used to create the pipeline necessary to deploy the Docker Stack.

Here is a list of things that need to be provided before starting.

- The Azure Load Balancer, public IP, Azure DNS entry, and external ports need to be configured and open.
- Decide what Docker cluster to use for deployment.
- Understanding of Jenkins and access into Jenkins
- Repository and branch created that has the code you want to deploy with the files from the template repo.
- Deployment key created and added to Jenkins
- Access into Docker cluster and collection created.
- Understanding of git commands

### Jenkinsfile Parameter

| **Parameter/Variable** | **Definition** | **Customizable** |
| --- | --- | --- |
| workspace | The workspace is defined as the present working directory for the Jenkins job. | No |
| build\_cmd | The build\_cmd can be used to replace a value in the Dockerfile.  Currently there is no values needing any change. | Yes, but docker template is not using it. |
| dir\_rand | The dir\_rand is used as the suffix of the version file version\_${dir\_rand).html.  This will be modified later to be used for PHP.  This is done so that it&#39;s not easy for someone to guess the file name. | Yes |
| slack\_channel | The slack\_channel is used by the pipeline to send messages to.  At the time, it not easy to which between channels because slack grants the application only to one channel.  There may be was to create new tokens but in Jenkins the token is placed as a global setting.  Jenkins offers different context of settings and using this method my allow the configuration of Jenkins to talk to multiple channels but the Slack plugin was to be compatible with that.   | Yes, with conditions |
| slack\_red | Slack\_red is used to define red in Slack | Yes |
| slack\_green | Slack\_green is used to define green in Slack | Yes |
| slack\_blue | Slack\_blue is used to define blue in Slack | Yes |
| git\_branch | The branch used for the pipeline | Yes |
| git\_id | The that ID Jenkins has defined for the git private key used to access the repo. | Yes |
| git\_url | [The url used to access the GitHub repo.  Example:  git@github.com:AEG-Presents/docker\_template.git](mailto:git@github.com) | Yes |
| docker\_stack\_name | The docker\_stack\_name is the name of what Docker will use when creating the stack.  The name should be &lt;agency&gt;&lt;project&gt;&lt;environment&gt;.  Example: mediamonks-bowery-production | Yes |
| docker\_server | The docker\_server is used to tell the pipeline which Docker cluster to connect into.  The syntax is:  tcp://ucp-aegdocker.westus.cloudapp.azure.com:443.   The UCP address is the one that needs to be entered.  Use either the WestUS or the WestUS2. | Yes |
| docker\_server\_id | The docker\_server\_id is the Jenkins ID that is defined within Jenkins that included the client bundle certs to gain access into Docker. | Yes |
| docker\_registry | The docker\_registory variable is the hostname of the Docker DTR.  Values are listed above. | Yes |
| docker\_registry\_id | The docker\_registry\_id is the Jenkins ID that is defined within Jenkins that is the username and password for Jenkins to get into DTR. | Yes |
| docker\_compose | The docker\_compose variable is the file name of the docker compose file to be used without the extension at the end.  For example docker-compose.tmpl would be listed as docker-compose. | Yes |
| docker\_dtr\_tag | The docker\_dtr\_tag variable is used to tag the docker image with the correct name.  Which is in this format: &lt;DTR&gt;/&lt;DTR org&gt;/&lt;DTR Repo&gt; .  In the Jenkinsfile it shows, ${docker\_registry}/&lt;DTR org/&lt;DTR Repo&gt;.  Since the docker\_registry is the hostname of DTR, we can use the variable that was created earlier. | Yes |
| docker\_ext\_port | The docker\_ext\_port is used to define what Docker will expose to the Azure load balancer.  Network Flow: container:8888 → Docker\_Service (ext:int or 4040:8888) →  Azure Load Balancer (internal 4040, external 80).  In this flow, the docker\_ext\_port has the value of 4040 and is defined in the Docker compose file. | Yes, this value needs to be configed on the Azure load balancer as the internal port. |
| docker\_label | The docker\_label is used to define the Docker collection in the Docker compose file.  The collection needs to be created in Docker and the rights need to be granted to the Jenkins user in order to deploy the stack.  Example: /Dev/AEG/DockerTemplate | Yes |
| docker\_cnt | The docker\_cnt value is numeric and it is used to define how many container should be created in the stack.  The value should be between 1 - 4.  Anything additional needs to be discussed with AEG. | Yes |
| site\_url | The site\_url value is the URL of what will access the site once it&#39;s deployed.  This is only used in the slack notification. | Yes |
